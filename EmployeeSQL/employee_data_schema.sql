from sqlalchemy import create_engine, MetaData, Table, Column, ForeignKey, Integer, String, PrimaryKeyConstraint, ForeignKeyConstraint

# Create an engine to connect to your SQLite database
engine = create_engine('sqlite:///path_to_your_database.db')

# Enable foreign key support in SQLite
# This is necessary for SQLite to enforce foreign key constraints
with engine.connect() as conn:
    conn.execute('PRAGMA foreign_keys = ON')

# Define the schema using MetaData
metadata = MetaData()

# Define the departments table
departments = Table(
    'departments',
    metadata,
    Column('dept_no', String, primary_key=True),
    Column('dept_name', String, nullable=False)
)

# Define the dept_emp table
dept_emp = Table(
    'dept_emp',
    metadata,
    Column('emp_no', Integer, nullable=False),
    Column('dept_no', String, nullable=False),
    PrimaryKeyConstraint('emp_no', 'dept_no'),
    ForeignKeyConstraint(['emp_no'], ['employees.emp_no']),
    ForeignKeyConstraint(['dept_no'], ['departments.dept_no'])
)

# Define the dept_manager table
dept_manager = Table(
    'dept_manager',
    metadata,
    Column('dept_no', String, nullable=False),
    Column('emp_no', Integer, nullable=False),
    PrimaryKeyConstraint('dept_no', 'emp_no'),
    ForeignKeyConstraint(['dept_no'], ['departments.dept_no']),
    ForeignKeyConstraint(['emp_no'], ['employees.emp_no'])
)

# Define the employees table
employees = Table(
    'employees',
    metadata,
    Column('emp_no', Integer, primary_key=True),
    Column('emp_title_id', String, nullable=False),
    Column('birth_date', String, nullable=False),
    Column('first_name', String, nullable=False),
    Column('last_name', String, nullable=False),
    Column('sex', String, nullable=False),
    Column('hire_date', String, nullable=False),
    ForeignKeyConstraint(['emp_title_id'], ['titles.title_id'])
)

# Define the salaries table
salaries = Table(
    'salaries',
    metadata,
    Column('emp_no', Integer, primary_key=True),
    Column('salary', Integer, nullable=False),
    ForeignKeyConstraint(['emp_no'], ['employees.emp_no'])
)

# Define the titles table
titles = Table(
    'titles',
    metadata,
    Column('title_id', String, primary_key=True),
    Column('title', String, nullable=False)
)

# Create the tables in the database
metadata.create_all(engine)
