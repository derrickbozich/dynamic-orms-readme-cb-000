require_relative "../config/environment.rb"
require 'active_support/inflector'

class Song


  def self.table_name
    self.class.to_s.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash = true

    sql = "PRAGMA table_info('#{table_name}')"

    table_info = DB[:conn].execute(sql)

    column_names = []
    table_info.each do |column|
      column_names << column["name"]
    end

    column_names.compact
  end

  self.column_names.each do |column|
    attr_accessor column.to_sym
  end

  def initialize(options={})
    options.each do |key, value|
      self.send("#{key}"=, value)
    end
  end


  def save

  end

  def table_name_for_insert
    self.class.table_name
  end

  def values_for_insert
    values = []
    self.class.column_names.each do |column|
      values << "'#{send(column)}'" unless send(column).nil?
    end
  end

  def col_names_for_insert
    self.class.column_names.delete_if {|column| column = "id"}.join(", ")
  end

  def self.find_by_name(name)

  end

end
