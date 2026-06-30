#CLOTHING STORE DATABASE

library(sqldf)
library(ggplot2)

getwd()

clothing_store <- read.csv("P9-OLTP.csv")

#Type of items sold at the store

items_sold <-  sqldf(
          "SELECT DISTINCT Description
          FROM clothing_store ")

# COUNT HOW MANY ITEMS WERE BOUGHT and create a graph 

number_of_items <- sqldf("
                         SELECT Description, COUNT(*) as items_bought
                         FROM clothing_store
                         GROUP BY Description
                         ORDER BY items_bought DESC
                         LIMIT 10
                         ")

items_graph <- ggplot(number_of_items, aes(x=Description, y= items_bought))+
  geom_col(position="dodge",fill= "red", colour="black") +
  labs(
    x="Types of Items bought",
    y="Number of Items Bought",
    title="Total number of Items Bought "
  )

print(items_graph)


#State that the store ships its items from

state_order <- sqldf("
                     SELECT DISTINCT Shipping_State
                     FROM clothing_store
                     ")


#Seeing which items costs 
      #Greater than R50

item_50 <- sqldf("
                   SELECT DISTINCT Description
                   FROM clothing_store
                   WHERE Retail_Price >= 50
                   ")
      #Greater than 100

item_100 <-  sqldf("
                   SELECT DISTINCT Description
                   FROM clothing_store
                   WHERE Retail_Price >= 100
                   ")

      # Greater than 150

item_150 <- sqldf("
                   SELECT DISTINCT Description
                   FROM clothing_store
                   WHERE Retail_Price >= 150
                   ")

#ITEMS BOUGHT THAT RECEIVED A LOYALTY DISCOUNT

bought_disc <- sqldf("
                     SELECT Description, Retail_Price, Loyalty_Discount
                     FROM clothing_store
                     WHERE Loyalty_Discount > 0.00
                     ")

#RELATIONSHIP BETWEEN LOYALTY DISCOUNT(0.05) AND THE RETAIL PRICE OF THE ITEM

        #Different Loyalty Discounts
 
loyalty_dis <- sqldf("
                     SELECT DISTINCT Loyalty_Discount
                     FROM clothing_store
                     ")

# Loyalty discount(0.05)and price being less than 50
loyalty_49 <-  sqldf("
                     SELECT Loyalty_Discount,Retail_Price
                     FROM clothing_store
                     WHERE Retail_Price < 50
                     AND Loyalty_Discount >= 0.05
                     ")


        # Loyalty discount(0.05)and price being greater than 50
loyalty_50 <-  sqldf("
                     SELECT Loyalty_Discount,Retail_Price
                     FROM clothing_store
                     WHERE Retail_Price >= 50
                     AND Loyalty_Discount >= 0.05
                     ")

        # Loyalty discount(0.05)and price being greater than 100

loyalty_100 <-  sqldf("
                     SELECT Loyalty_Discount,Retail_Price
                     FROM clothing_store
                     WHERE Retail_Price >= 100
                     AND Loyalty_Discount >= 0.05
                     ")
        # Loyalty discount(0.05)and price being greater than 150

loyalty_150 <-  sqldf("
                     SELECT Loyalty_Discount,Retail_Price
                     FROM clothing_store
                     WHERE Retail_Price >= 150
                     AND Loyalty_Discount >= 0.05
                     ")

#RELATIONSHIP BETWEEN ITEM BOUGHT AND THE LOYALTY_DISCOUNTS THAT WE HAVE
              
       #Different items and a loyalty discount of 0

item_loy0.00 <- sqldf("
                     SELECT DISTINCT Description,Loyalty_Discount
                     FROM clothing_store
                     WHERE Loyalty_Discount = 0.00
                     ")

#Different items and a loyalty discount of 0.01

item_loy0.01 <- sqldf("
                     SELECT DISTINCT Description,Loyalty_Discount
                     FROM clothing_store
                     WHERE Loyalty_Discount = 0.01
                     ")


#Different items and a loyalty discount of 0.02

item_loy0.02 <- sqldf("
                     SELECT DISTINCT Description,Loyalty_Discount
                     FROM clothing_store
                     WHERE Loyalty_Discount = 0.02
                     ")
#RELATIONSHIP BETWEEN STATES AND LOYALTY DISCOUNT

discount_state <- sqldf("
                     SELECT Shipping_State,sum(Loyalty_Discount) as tot_dis_perstate
                     FROM clothing_store
                     GROUP BY Shipping_State
                     ORDER BY tot_dis_perstate DESC
                     LIMIT 9
                     ")

#GETTING A ABBREVIATION OF THE STATES

discount_state$Shipping_State <- substr(discount_state$Shipping_State,1,6)

#BAR GRAPH TO SHOW THE NUMBER OF DISCOUNT EACH STATE GAVE

discount_graph <- ggplot( discount_state, aes( x= Shipping_State, y=tot_dis_perstate))+
  geom_col(fill= "pink", colour= "white") +
  labs(
    x="Shipping States",
    y= "Total Discount",
    title= "Total number of discounts offered per State" ) +
  theme_minimal()
print(discount_graph)     
  

# COUNT THE TRANSACTIONS WE HAVE PER STATES 

orders_state <- sqldf("
                    SELECT Shipping_State, COUNT(*) AS tot_orders_state
                    FROM clothing_store
                    GROUP BY Shipping_State
                    Order by tot_orders_state DESC
                    LIMIT 9
                    ")
     

#BAR GRAPH TO SHOW THE NUMBER OF ORDERS EACH STATE HAS

#GETTING A ABBREVIATION OF THE STATES

orders_state$Shipping_State <- substr(orders_state$Shipping_State,1,5)

order_graph <- ggplot(orders_state, aes(x=Shipping_State, y= tot_orders_state))+
                       geom_col(position="dodge",fill= "blue", colour="lightblue") +
                       labs(
                         x="Shipping States",
                         y="Number of Orders Per State",
                         title="Total number of Orders Per State "
                       )

print(order_graph)


#CUSTOMER BEHAVIOUR

#UNIQUE SURNAMES AND TRY TO SEE IF THE NAMES MATCH OR NOT

unique_n <- sqldf("
                  SELECT DISTINCT Name
                  FROM clothing_store
                  ")

unique_s <- sqldf("
                  SELECT DISTINCT Surname
                  FROM clothing_store
                  ")

unique_sn <- sqldf("
                  SELECT DISTINCT Name, Surname
                  FROM clothing_store
                  ")



#TOP SPENDING CUSTOMER
                            
customer_spending <- sqldf("
                           SELECT Surname, COUNT(*) AS customer_expenditure
                           FROM clothing_store
                           GROUP BY Surname
                           ORDER BY customer_expenditure Desc
                           ")







