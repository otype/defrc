module Abstract
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def abstract_methods(*args)
      args.each do |name|
        class_eval(<<-END, __FILE__, __LINE__)
          def #{name}(*args)
            raise NotImplementedError.new("You must implement #{name}.")
          end
        END
      end
    end
  end
end

require 'rubygems'
require 'spec'

describe "abstract methods" do
  before(:each) do
    @klass = Class.new do
      include Abstract

      abstract_methods :foo, :bar
    end
  end

  it "raises NotImplementedError" do
    proc {
      @klass.new.foo
    }.should raise_error(NotImplementedError)
  end

  it "can be overridden" do
    subclass = Class.new(@klass) do
      def foo
        :overridden
      end
    end

    subclass.new.foo.should == :overridden
  end
end

