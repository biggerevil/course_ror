# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      name_in_sym = "@#{name}".to_sym
      # Добавляем геттер для переменной
      define_method(name) { instance_variable_get(name_in_sym) }
      # Добавляем сеттер для переменной, причём внутри сеттера будет несколько строк кода
      define_method("#{name}=".to_sym) do |value|
        # Здесь мы просто меняем значение переменной
        instance_variable_set(name_in_sym, value)
        # А строчками ниже мы создаём history, если он отсутствует, и добавляем новое значение
        # в этот массив
        instance_eval(
          "@#{name}_history ||= []
          @#{name}_history.push(value)"
        )
      end
      # Определяем геттер для #{name}_history
      define_method("#{name}_history") do
        return if "#{name}_history".nil?

        instance_variable_get("@#{name}_history")
      end
    end
  end

  def strong_attr_accessor(name, type)
    # Создаём геттер
    name_in_sym = "@#{name}".to_sym
    define_method(name) { instance_variable_get(name_in_sym) }
    # Создаём сеттер
    define_method("#{name}=".to_sym) do |value|
      raise RuntimeError if value.class != type

      instance_variable_set(name_in_sym, value)
    end
  end
end

class Test
  extend Accessors

  attr_accessor_with_history :name, :age
  strong_attr_accessor :iq, Integer
end

# t = Test.new
#
# # Код для проверки strong_attr_accessor
# t.iq = 5
# puts "t.iq = #{t.iq}"
# # Строчка ниже выбрасывает исключение (как и должна)
# # t.iq = "hi"
#
# # Код для проверки attr_accessor_with_history
# puts t.age
# t.age = "Вася"
# puts t.age
# t.age = "Игорь"
# puts t.instance_variables
# puts "t.instance_variable_get(\"@age_history\") = #{t.instance_variable_get("@age_history")}"
# puts "t.age_history = #{t.age_history}"
