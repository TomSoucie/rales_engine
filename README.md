# RALES ENGINE

Internal API for sales involving merchants and their transactions, invoices, items, and customers.

This application uses:

Ruby version 2.3.3
Rails version 5.1.2
PostgreSQL version 9.6.1

Run Rales Engine now!

```
$ git clone https://github.com/TomSoucie/rales_engine.git
$ cd rales_engine
$ bundle
$ rake db:create
$ rake db:migrate
$ bundle exec rake csv_handler:all
```

Relationship and Business Intelligence endpoints
```
/api/v1/merchants/:id/invoices
/api/v1/merchants/:id/items
/api/v1/merchants/:id/revenue
/api/v1/merchants/:id/revenue?date=x
/api/v1/merchants/:id/customers_with_pending_invoices
/api/v1/merchants/:id/favorite_customer
/api/v1/merchants/most_revenue?quantity=x
/api/v1/merchants/most_items?quantity=x


/api/v1/customers/:id/favorite_merchant

/api/v1/items/:id/invoice_items
/api/v1/items/:id/merchant
/api/v1/items/:id/best_day
/api/v1/items/most_items?quantity=x
/api/v1/items/most_revenue?quantity=x

/api/v1/invoices/:id/transactions
/api/v1/invoices/:id/invoice_items
/api/v1/invoices/:id/items
/api/v1/invoices/:id/customer
/api/v1/invoices/:id/merchant

/api/v1/invoice_items/:id/invoice
/api/v1/invoice_items/:id/item

/api/v1/transactions/:id/invoice

/api/v1/customers/:id/invoices
/api/v1/customers/:id/transactions
```

### Verify Spec Harness Compliance

# RalesEngine Spec Harness

This gem contains an http-based spec harness for validating
functionality on student implementations of the
[RalesEngine](https://github.com/turingschool/lesson_plans/blob/master/ruby_03-professional_rails_applications/rails_engine.md)
project at Turing.

## Installation

To use this repository, simply clone it onto your machine and bundle:

```
git clone https://github.com/turingschool/rales_engine_spec_harness.git
cd rales_engine_spec_harness
bundle
```

## Usage

Run the tests with `rake`:

OR:

Run individual tests with `rake test TEST="test_path"/"test_name".rb`:
Example : `rake test TEST=test/endpoints/transactions_test.rb`
