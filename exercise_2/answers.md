**Exercise Series 2**

Student: Brian Schweigler (16-102-071)



**B iii.)**

Both queries used a sequential scan to find the results.



**B vi.)**

With the added index, the query on the rental database could use the bitmap heap scan (thanks to the index).

For the country table, as it is quite small the sequential scan seemed to still be faster.

Easiest way to compare these is through the cost parameter, which decreased for the rental database, but stayed the same for the country database.





**C ii.)**

First we aggregate through a nested loop and sequential scan on staff.

Then, we filter on this based on our name 'Mike'.

Afterwards, a simple index only scan is done on payment, so we can then compare the indexes in the next step.

After comparing the indexes based on the condition staff_id = staf.staff_id we will arrive at our result by counting afterwards.