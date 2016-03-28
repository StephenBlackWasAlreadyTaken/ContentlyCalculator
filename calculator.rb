require 'bigdecimal'

class String
  def nan?
    self !~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
  end
end

module Calculator
  class Parser
    attr_reader :input_string, :array, :formated_input_string
    def initialize(calculator_string)
      @formated_input_string = string_reformat(calculator_string.dup)
      string_array = formated_input_string.split(' ')
      @array = string_array.map { |element| element.nan? ? element : ::BigDecimal.new(element) }
    end

    def run
      generate_expressions(array).evaluate
    end

    private

    def generate_expressions(parsed_array)
      if parsed_array.index('(') 
        generate_expressions(inner_expression(parsed_array))
      else
        Expression.new(parsed_array)
      end
    end

    def inner_expression(array)
      left_paren = array.rindex('(')
      right_paren = array[left_paren..(array.length - 1)].index(')') + left_paren
      inner_array = array[(left_paren + 1)..(right_paren - 1)]
      expression = Expression.new(inner_array)
      ArraySquisher.squish(array, expression, left_paren + 1, inner_array.length)
    end

    def string_reformat(string)
      string = add_spaces_around_operations(string)
      make_implicit_multiplication_explicit(string)
    end

    def add_spaces_around_operations(string)
      if index = string.index(/[^\s][-+\/*()\^]/)
        add_spaces_around_operations(string.insert(index + 1, ' '))
      elsif index = string.index(/[+\/*()\^][^\s]/)
        add_spaces_around_operations(string.insert(index + 1, ' '))
      else
        handle_negative_vs_subtraction(string)
      end
    end

    def handle_negative_vs_subtraction(string)
      if index = string.index(/[^-+\/*(\^][\s][-][\d]/)
        handle_negative_vs_subtraction(string.insert(index + 3, ' '))
      else
        string
      end
    end

    def make_implicit_multiplication_explicit(string)
      if index = string.index(/[^(-+\/*\^][\s][(]/)
        make_implicit_multiplication_explicit(string.insert(index + 1, ' *'))
      else
        string
      end
    end
  end

  class Expression
    attr_reader :expression_array
    EXPONENT = '^'.freeze
    MULTIPLICATION = '*'.freeze
    DIVISION = '/'.freeze
    ADDITION = '+'.freeze
    SUBTRACTION = '-'.freeze
    ORDER_OF_OPERATIONS = [[EXPONENT], [MULTIPLICATION, DIVISION], [ADDITION, SUBTRACTION]].freeze

    def initialize(expression_array = [])
      @expression_array = expression_array
    end

    def evaluate
      inner_evaluation = expression_array.map{ |element| element.class == Expression ? element.evaluate : element }
      perform_order_of_operations(inner_evaluation).first
    end

    private

    def perform_order_of_operations(running_evaluation)
      ORDER_OF_OPERATIONS.each do |operation_set|
        if (running_evaluation & operation_set).length > 0
          operation = running_evaluation.find { |element| operation_set.include? element }
          running_evaluation = evaluate_operation(running_evaluation, operation)
        end
      end
      running_evaluation
    end

    def evaluate_operation(array, operation_string)
      if index = array.index(operation_string)
        new_value = perform_operation(array[index - 1], array[index + 1], operation_string)
        array = ArraySquisher.squish(array, new_value, index)
      end
      perform_order_of_operations(array)
    end

    def perform_operation(value_1, value_2, operation_string)
      case operation_string
      when EXPONENT
        value_1 ** value_2
      when MULTIPLICATION
        value_1 * value_2
      when DIVISION
        value_1 / value_2
      when ADDITION
        value_1 + value_2
      when SUBTRACTION
        value_1 - value_2
      end
    end
  end
end

class ArraySquisher
  def self.squish(array, new_value, index, length = 1)
    [].tap do |a|
      a.push *array[0..(index - 2)] if (index > 2)
      a.push *new_value
      a.push *array[(index + length + 1)..(array.length - 1)] if (array.length > index + length + 1)
    end
  end
end