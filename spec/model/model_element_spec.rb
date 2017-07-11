require 'spec_helper'
require 'cfn-model/model/model_element'

class AnotherResource < ModelElement
  attr_accessor :field1
end

describe ModelElement do
  describe '#to_s' do
    context 'field1 has value' do
      it 'returns string with field1 value' do
        expected_string = <<END
{
  @field1=moo
  @logical_resource_id=1
  @resource_type=AWS::Foo::Moo

}
END
        another_resource = AnotherResource.new
        another_resource.field1 = 'moo'
        another_resource.logical_resource_id = 1
        another_resource.resource_type = 'AWS::Foo::Moo'

        expect(another_resource.to_s).to eq expected_string
      end
    end
  end

  describe '#==' do
    context 'unequal' do
      it 'returns false' do
        another_resource = AnotherResource.new
        another_resource.field1 = 'moo'
        another_resource.logical_resource_id = 1
        another_resource.resource_type = 'AWS::Foo::Moo'

        other_resource = AnotherResource.new
        other_resource.field1 = 'moo2'
        other_resource.logical_resource_id = 2
        other_resource.resource_type = 'AWS::Foo::Moo'

        expect(another_resource).to_not eq other_resource
      end
    end

    context 'equal' do
      it 'returns true' do
        another_resource = AnotherResource.new
        another_resource.field1 = 'moo2'
        another_resource.logical_resource_id = 1
        another_resource.resource_type = 'AWS::Foo::Moo'

        other_resource = AnotherResource.new
        other_resource.field1 = 'moo2'
        other_resource.logical_resource_id = 2
        other_resource.resource_type = 'AWS::Foo::Moo'

        expect(another_resource).to eq other_resource
      end
    end
  end
end
