# Fixes for the "latest-comment" n+1 queries problem

Do you have to fetch the latest "x" of each record?

One example of this problem is trying to get the latest comment on a list of
posts, but there are others, like the last review in a list of products, or the
cheapest price, the latest payment for each costumer, etc…

This the code used in the post [5 ways to fix the latest-comment n+1
problem](https://bhserna.com/5-ways-to-fix-the-latest-comment-n-1-problem.html).

You can use it to run the examples, play with the the code and seed values, in
order to pick the right solution for you current case.

## How to run the examples

1. **Create a postgres database** with `createdb latest_comment_fixes` -  As
   you can see the in `db/config.rb` the name of the database is hardcoded, so
   you will need to create a database with that name.

2. **Run the examples** with `ruby fixes_examples/<file name>` - for example
   `ruby fixes_examples/01_default_order.rb`.

3. **Change the posts and comments count**  with `Seeds.run(posts_count: 10,
   comments_count: 10)` - You can change de count of post or comments per post,
   to test different scenarios.

3. **If you don't want to reset the seeds** comment `Seeds.run` - This will use
   the records from the last example run.
