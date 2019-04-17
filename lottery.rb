# this lottery system is implemented by ruby 


# each customer has his name, pool of lottery, tickets stands for how many tickets this customer gets
class Customer
    attr_accessor :name, :lottery, :tickets

    def initialize(s)
        @name = s
        @lottery = []
        @tickets = 0
    end

end

# our lottery system has a tickets_queue which is the sum of all customer's lottery
# it also has a customer_queue which contains all the customers
# count is the counter, everytime when someone lottery to the pool it increases
class Lottery
    attr_accessor :tickets_queue, :customer_queue, :count
    
    def initialize
        @tickets_queue = []
        @customer_queue = []
        @count = 0
    end
        
    # find the customer corresponding to the name
    def find_customer(name)
        @customer_queue.each do |c|
            
            if c.name == name
                return c
            end            
        end           
    end
    
    # given a list of tickets, find the winners to win the tickets
    def find_winner(arr)
                
        (0..@customer_queue.size - 1).each do |i|
            (0..arr.size - 1).each do |j|
                
                if @customer_queue[i].lottery.include?(arr[j])
                    @customer_queue[i].tickets +=1
                end
            end
             
        end
        
        (0..@customer_queue.size - 1).each do |i|
            if @customer_queue[i].tickets > 0
                print @customer_queue[i].name + ": "
                puts @customer_queue[i].tickets
            end
        end
       
    end
        
    # this method is used when someone add lottery to the pool
    def add_lottery(name, number)
        
        
        # if the customer is not in the list, create a new customer
        flag = false
        
        @customer_queue.each do |c|
            if c.name == name
                flag == true
            end
        end
                       
        if flag == false
            customer = Customer.new(name)
            @customer_queue.push(customer)
        end
        
        
        # add the lottery to both tickets_queue and the customer's lottery_queue
        (@count..@count + number-1).each do |i| 
            @tickets_queue.push(i)
            find_customer(name).lottery.push(i)
        end
       
        # increase the counter
        @count += number
  
    end     
  
     
    # this method is used to radonmly pick the winners
    def draw(number)
        # here the number stands for how many tickets we are going to release
        result = []
       
        for i in (0..number - 1) do i
            n = rand(@tickets_queue.size - 1)
           
            ticket = @tickets_queue[n]
            result.push(ticket)
           
            @tickets_queue.delete_at(n)
       
        end
               
        find_winner(result)
       
    end
end



# example for lottery. We make 5 customers and they enter 1 - 5 to the lottery pool
# So there will be 15 in total, and we can choose a number between 1-15 to choose the winners
# here I use 3
# to see the result, just type "ruby lottery.rb" in the bash

lottery = Lottery.new()

customer1 = Customer.new("David")
customer2 = Customer.new("Tom")
customer3 = Customer.new("Jack")
customer4 = Customer.new("Chris")
customer5 = Customer.new("Nick")

lottery.add_lottery("David", 1)
lottery.add_lottery("Tom", 2)
lottery.add_lottery("Jack", 3)
lottery.add_lottery("Chris", 4)
lottery.add_lottery("Nick", 5)

lottery.draw(3)