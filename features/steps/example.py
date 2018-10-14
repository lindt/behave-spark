from behave import *
from behave_spark.wrapper import spark, hive
from behave_spark.parser import to_dataframe


@given('a flight of a rocket with an')
@given('a falcon X rocket with an inertial messurement unit')
@when('it flew 10 times for each 10 hours')
@then('the inertial meassurement unit has a total of 100 operating hours')
@hive
def step_impl(context):
    pass  # TODO


@given('a gherkin table as input')
def step_impl(context, ):
    context.input = context.table


@given('a table')
def step_impl(context):
    context.data = to_dataframe(context.table)


@given('another table')
def step_impl(context):
    context.data2 = to_dataframe(context.table)


@then('it equals')
def aa(context):
    from nose.tools import eq_

    expected = to_dataframe(context.table)

    eq_(sorted(expected.keys().tolist()), sorted(context.data.keys().tolist()))
