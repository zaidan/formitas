# Experiment on how to dedup unit specs in dm-2/dkubb style

module Kernel
  def unit_spec(&block)
    file = caller(1).first.split(':').first
    parts = file.split('/spec/unit/').last.split('/')
    match = parts.last.match(/\A(.*)_spec.rb\Z/)
    match || raise
    parts = parts[0..-2]
    singleton = false
    if %w(singleton_methods class_methods).include?(parts.last)
      parts = parts[0..-2]
      singleton = true
    end
    constant = parts.map { |name| name.capitalize }.inject(Object) do |constant, name|
      name = name.split('_').map(&:capitalize).join('')
      constant.const_get(name)
    end

    delim = singleton ? '.' : '#'
    method_name = match[1]

    method_name = method_name.gsub(/_bang\Z/,'!')
    method_name = method_name.gsub(/_predicate\Z/,'?')


    describe constant, "#{delim}#{method_name}" do
      def self.method_args(&block)
        let(:method_args, &block)
      end

      def self.object_arg(&block)
        object_args { [instance_eval(&block)] }
      end

      def self.method_arg(&block)
        method_args { [instance_eval(&block)] }
      end

      def self.attributes(&block)
        let(:attributes, &block)
        object_args { [attributes] }
      end

      def self.object_args(&block)
        let(:object_args, &block)
      end

      def self.object(&block)
        let(:object, &block)
      end

      def self.command_method
        it_should_behave_like('a command method')
      end

      def self.idempotent_method
        it_should_behave_like('an idempotent method')
      end

      def class_under_test
        described_class
      end

      if singleton
        object { class_under_test }
      else
        object_args { [] }
        object      { class_under_test.new(*object_args) }
      end

      method_args { [] }
      subject { object.public_send(method_name, *method_args) }

      class_eval(&block)
    end
  end
end
