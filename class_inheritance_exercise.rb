require 'byebug'

class Employee
    attr_reader :name, :salary, :title, :boss

    def initialize(name, salary, title, boss = nil)
        @name = name
        @salary = salary
        @title = title
        @boss = boss
    end

    def bonus(multiplier)
        salary * multiplier
    end
end

class Manager < Employee
    attr_reader :employees

    def initialize(name, salary, title, employees, boss = nil)
        super(name, salary, title, boss)
        @employees = employees
    end

    def bonus(multiplier)
        total_sub_salary * multiplier
    end

    def total_sub_salary
        employees.inject(0) do |total, employee|
            total += employee.total_sub_salary if employee.class == Manager
            total + employee.salary
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    david = Employee.new('David', 10000, 'TA', 'Darren')
    shawna = Employee.new('Shawna', 12000, 'TA', 'Darren')
    darren = Manager.new('Darren', 78000, 'TA Manager', [david, shawna], 'Ned')
    ned = Manager.new('Ned', 1000000,  'Founder', [darren])

    p ned.bonus(5) # => 500_000
    p darren.bonus(4) # => 88_000
    p david.bonus(3) # => 30_000
end