require 'set'

class Hierarchy
  def initialize(employee_info)
    @org_tree = Hash.new{|k,v| k[v] = Set.new}
    create_relationships(employee_info)
  end

  def manager_ids
    @org_tree.keys
  end

  def add_employee(manager_id, employee_id)
    @org_tree[manager_id] << employee_id
  end

  def direct_report_ids(manager_id)
    @org_tree[manager_id]
  end

  private

  def create_relationships(employee_info)
    employee_info.each do |employee_hash|
      employee_id = employee_hash['id']
      manager_id = employee_hash['manager_id']

      add_employee(manager_id, employee_id)
    end
  end
end