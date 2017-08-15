#!/usr/bin/env python3
''' 
1. Get a connection to a provided sqlite db file
1. Get all of the table names and schema
1. Pull in all of the tables as Pandas DataFrames with column headers from schema
1. Fix/ normalise timestamps and/or reindex to TimeSeries??
'''

import pandas as pd
import numpy as np #might not need
from sqlalchemy import create_engine
#import sqlite3 # must have installed for SQLAlchemy/Pandas to magic the SQL for sqlite3

def get_sqlite_dataframes( sqlite_file ):
    '''Given a sqlite file path, connect, pull schema, tables, to return a dict by table name of Pandas dataframes from all tables'''

    ## local vars
    table_dataframes = {}

    ## connect by creating engine
    engine = create_engine(sqlite_file)
    ## get schema
    all_schema = engine.execute('.schema')
    ## list tables, get column names
    results = all_schema.results() #null
    column_names = get_column_names( results )

    ## for table in table_list
    ##      read table into dataframe with column names
    ##      return dataframe
    ## add new df to table_dataframes dict
    ## normalise time, reindex, other fixes?

    return( table_dataframes )

def get_column_names ( sql_results ):
    '''take in a SQLAlchemy results object from a .schema query and return a list of the tables'''

    table_list=[]
    ## for line in result, get the table name (only) and add it to the list as a simple string

    return(table_list)

def normalise_volatility_timestamps (dataframe):
    '''process a DataFrame a Volatility plugin output data for easier analysis '''
    
    easier_time_df = pd.DataFrame() ##null

    return(easier_time_df)

