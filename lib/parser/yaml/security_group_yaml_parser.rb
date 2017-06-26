require 'parser/security_group_parser'

class SecurityGroupYamlParser < SecurityGroupParser

  protected

  ##
  # Return nil if
  def resolve_group_id(group_id)
    return nil if group_id.is_a? String

    # an imported value can only yield a literal to an external sg vs. referencing something local
    if !group_id['Ref'].nil?
      group_id['Ref']
    elsif !group_id['Fn::GetAtt'].nil?
      logical_resource_id_from_get_att group_id['Fn::GetAtt']
    else # !group_id['Fn::ImportValue'].nil?
      # anything else will be string manipulation functions
      # which again leads us back to a string which must be an external security group known out of band
      # so don't/can't link it up to a security group
      return nil
    end
  end

  private

  def logical_resource_id_from_get_att(attribute_spec)
    puts attribute_spec
    if attribute_spec.is_a? Array
      if attribute_spec[1] == 'GroupId'
        return attribute_spec.first
      else
        # this could be a reference to a nested stack output so treat it as external
        # and presume the ingress is freestanding.
        return nil
      end
    elsif attribute_spec.is_a? String
      if attribute_spec.split('.')[1] == 'GroupId'
        return attribute_spec.split('.').first
      else
        # this could be a reference to a nested stack output so treat it as external
        # and presume the ingress is freestanding.
        return nil
      end
    end
  end
end