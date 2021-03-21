# ETL-project

ETL of Kaggle data on Steam games

## Getting Started

This project utilizes two datasets from [Kaggle](https://www.kaggle.com/ "Kaggle"):
- CSV data - [Popularity of Games on Steam](https://www.kaggle.com/michau96/popularity-of-games-on-steam/ "Popularity of Games on Steam")
- JSON data - [80000 Steam Games Dataset](https://www.kaggle.com/deepann/80000-steam-games-dataset/ "80000 Steam Games Dataset")

The jupyter notebook file (ETL-steam.ipynb] contains all steps needed for extracting, transforming, and loading the data into a Postgres SQL databas

The schema.sql file contains the "create table" instructions to prep the SQL database before loading

The Resources folder contains the csv file (the JSON file was too large to import to GitHub, but is available at the above link for download)

## Features and Process

- ETL-steam.ipynb (Jupyter Notebook)
  - Dependencies:
    - Imports the following modules: pandas, json, and sqlachemy
    - A seperate config.py file is needed to provide a username and password for your postgres database
  - Extract CSV:
    - Stores the popularity data as a dataframe
  - Transform CSV dataframe (cleaning steps)
    -  Columns are renamed for easier use
    -  NaN in "monthly_change" column converted to zero
  - Extract JSON:
    - Opens using json.load, then converted to pandas dataframe (normalized)
  - Transform JSON dataframe (cleaning steps)
    - Most of the original 41 columns contain primarily missing values, these are dropped
    - The full_desc.sort column contains mostly repetitive information and was dropped
    - The date column is inconsistent and many dates are missing, column was dropped
    - Columns are renamed for easier use
    - This leaves 4 columns for the remaining cleaning steps
      -  Price column: converted all NaN to zero, replaced "free" with zero, converted to numeric
      -  Developer column: converted all NaN to none, contained non-standard characters (rows using Chinenes and Japanese characters were dropped)
      -  Name column: converted all NaN to none, dropped all rows containing non-standard characters, replaced symbols with blanks
      -  Description column: The repetitive 16 characters at the beginning of each row was dropped ("About this game ")
  - Merge Dataframes:
    - The csv is a repeated measures (each game has data per month/year available on Steam from 2012 to 2021)
    - An inner join was used to merge the two dataframes based on name, resulting in 1,000 unique games in common to both dataframes
    - Data from the JSON was merged to match the repeated measures format of the CSV to not lose monthly data
    - Index was set as an ID column to be used as a Primary Key in SQL    
    - Final dataframe contains 80,722 rows and 11 columns
  - Load:
    - SQL schema for create table included in Jypyter Notebook and in the schema.sql file
    - Connection to postgres database uses port 5432 and uses sqlalchemy
    - Credentials for postgres were in a seperate config.py file (not included)
    - Merged dataframe was loaded into SQL using panadas.to_sql method
    - Data import was confirmed both in pgAdmin4 and by importing data back into the Jupyter Notebook
      

## Licensing by:

The code in this project is licensed under MIT license.
