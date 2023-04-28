#!/bin/bash

input_file="NNDSS-_TABLE_1EE._Salmonella.csv"
table_name="salmonella_table"
column_families=("reporting_area" "mmwr_year" "mmwr_week" "salmonella_paratyphi_infection_current_week" "salmonella_paratyphi_infection_previous_52_weeks" "salmonella_paratyphi_infection_2021" "salmonella_paratyphi_infection_2020" "salmonella_typhi_infection_current_week" "salmonella_typhi_infection_previous_52_weeks" "salmonella_typhi_infection_2021" "salmonella_typhi_infection_2020" "salmonellosis_current_week" "salmonellosis_previous_52_weeks" "salmonellosis_2021" "salmonellosis_2020" "location_1" "location_2" "reporting_area_sort" "geocode_latitude" "geocode_longitude")

echo "disable '$table_name'" | hbase shell
echo "drop '$table_name'" | hbase shell

# Create table and column families
echo "create '$table_name', '${column_families[0]}','${column_families[1]}','${column_families[2]}','${column_families[3]}','${column_families[4]}','${column_families[5]}','${column_families[6]}','${column_families[7]}','${column_families[8]}','${column_families[9]}','${column_families[10]}','${column_families[11]}','${column_families[12]}','${column_families[13]}','${column_families[14]}','${column_families[15]}','${column_families[16]}','${column_families[17]}','${column_families[18]}','${column_families[19]}'" | hbase shell
