#!/bin/bash

# read CSV file and store data in an array

line_count=0
declare -a data
while IFS= read -r line; do
  reporting_area=$(echo "$line" | awk -F ',' '{print $1}')
  mmwr_year=$(echo "$line" | awk -F ',' '{print $2}')
  mmwr_week=$(echo "$line" | awk -F ',' '{print $3}')
  salmonella_paratyphi_curr_week=$(echo "$line" | awk -F ',' '{print $4}')
  salmonella_paratyphi_prev_52=$(echo "$line" | awk -F ',' '{print $5}')
  salmonella_paratyphi_2021=$(echo "$line" | awk -F ',' '{print $6}')
  salmonella_paratyphi_2020=$(echo "$line" | awk -F ',' '{print $7}')
  salmonella_typhi_curr_week=$(echo "$line" | awk -F ',' '{print $8}')
  salmonella_typhi_prev_52=$(echo "$line" | awk -F ',' '{print $9}')
  salmonella_typhi_2021=$(echo "$line" | awk -F ',' '{print $10}')
  salmonella_typhi_2020=$(echo "$line" | awk -F ',' '{print $11}')
  salmonellosis_curr_week=$(echo "$line" | awk -F ',' '{print $12}')
  salmonellosis_prev_52=$(echo "$line" | awk -F ',' '{print $13}')
  salmonellosis_2021=$(echo "$line" | awk -F ',' '{print $14}')
  salmonellosis_2020=$(echo "$line" | awk -F ',' '{print $15}')
  location1=$(echo "$line" | awk -F ',' '{print $16}')
  location2=$(echo "$line" | awk -F ',' '{print $17}')
  reporting_area_sort=$(echo "$line" | awk -F ',' '{print $18}')
  latitude=$(echo "$line" | awk -F ',' '{print $19}')
  longitude=$(echo "$line" | awk -F ',' '{print $20}')

  echo $line
  # store data in array
  if [ $line_count -ne 0 ]; then
  	data+=( "$reporting_area,$mmwr_year,$mmwr_week,$salmonella_paratyphi_curr_week,$salmonella_paratyphi_prev_52,$salmonella_paratyphi_2021,$salmonella_paratyphi_2020,$salmonella_typhi_curr_week,$salmonella_typhi_prev_52,$salmonella_typhi_2021,$salmonella_typhi_2020,$salmonellosis_curr_week,$salmonellosis_prev_52,$salmonellosis_2021,$salmonellosis_2020,$location1,$location2,$reporting_area_sort,$latitude,$longitude" )
  fi
  line_count=$((line_count+1))

done < "NNDSS_-_TABLE_1EE._Salmonella.csv"

count=0
# execute HBase commands
for line in "${data[@]}"; do
reporting_area_data=$(echo "$line" | awk -F ',' '{print $1}')
mmwr_year_data=$(echo "$line" | awk -F ',' '{print $2}')
mmwr_week_data=$(echo "$line" | awk -F ',' '{print $3}')
salmonella_paratyphi_curr_week_data=$(echo "$line" | awk -F ',' '{print $4}')
salmonella_paratyphi_prev_52_data=$(echo "$line" | awk -F ',' '{print $5}')
salmonella_paratyphi_2021_data=$(echo "$line" | awk -F ',' '{print $6}')
salmonella_paratyphi_2020_data=$(echo "$line" | awk -F ',' '{print $7}')
salmonella_typhi_curr_week_data=$(echo "$line" | awk -F ',' '{print $8}')
salmonella_typhi_prev_52_data=$(echo "$line" | awk -F ',' '{print $9}')
salmonella_typhi_2021_data=$(echo "$line" | awk -F ',' '{print $10}')
salmonella_typhi_2020_data=$(echo "$line" | awk -F ',' '{print $11}')
salmonellosis_curr_week_data=$(echo "$line" | awk -F ',' '{print $12}')
salmonellosis_prev_52_data=$(echo "$line" | awk -F ',' '{print $13}')
salmonellosis_2021_data=$(echo "$line" | awk -F ',' '{print $14}')
salmonellosis_2020_data=$(echo "$line" | awk -F ',' '{print $15}')
location1_data=$(echo "$line" | awk -F ',' '{print $16}')
location2_data=$(echo "$line" | awk -F ',' '{print $17}')
reporting_area_sort_data=$(echo "$line" | awk -F ',' '{print $18}')
latitude_data=$(echo "$line" | awk -F ',' '{print $19}')
longitude_data=$(echo "$line" | awk -F ',' '{print $20}')

if [ -z "$reporting_area_data" ]; then
  echo "Skipping empty reporting_area"
  continue
fi

echo "put 'salmonella_table', '$count', 'reporting_area', '$reporting_area_data'"
echo "put 'salmonella_table', '$count', 'mmwr_year', '$mmwr_year_data'"
echo "put 'salmonella_table', '$count', 'mmwr_week', '$mmwr_week_data'"
echo "put 'salmonella_table', '$count', 'salmonella_paratyphi_infection_current_week', '$salmonella_paratyphi_curr_week_data'"
echo "put 'salmonella_table', '$count', 'salmonella_paratyphi_infection_previous_52_weeks', '$salmonella_paratyphi_prev_52_data'"
echo "put 'salmonella_table', '$count', 'salmonella_paratyphi_infection_2021', '$salmonella_paratyphi_2021_data'"
echo "put 'salmonella_table', '$count', 'salmonella_paratyphi_infection_2020', '$salmonella_paratyphi_2020_data'"
echo "put 'salmonella_table', '$count', 'salmonella_typhi_infection_current_week', '$salmonella_typhi_curr_week_data'"
echo "put 'salmonella_table', '$count', 'salmonella_typhi_infection_previous_52_weeks', '$salmonella_typhi_prev_52_data'"
echo "put 'salmonella_table', '$count', 'salmonella_typhi_infection_2021', '$salmonella_typhi_2021_data'"
echo "put 'salmonella_table', '$count', 'salmonella_typhi_infection_2020', '$salmonella_typhi_2020_data'"
echo "put 'salmonella_table', '$count', 'salmonellosis_current_week', '$salmonellosis_curr_week_data'"
echo "put 'salmonella_table', '$count', 'salmonellosis_previous_52_weeks', '$salmonellosis_prev_52_data'"
echo "put 'salmonella_table', '$count', 'salmonellosis_2021', '$salmonellosis_2021_data'"
echo "put 'salmonella_table', '$count', 'salmonellosis_2020', '$salmonellosis_2020_data'"
echo "put 'salmonella_table', '$count', 'location_1', '$location1_data'"
echo "put 'salmonella_table', '$count', 'location_2', '$location2_data'"
echo "put 'salmonella_table', '$count', 'reporting_area_sort', '$reporting_area_sort_data'"
echo "put 'salmonella_table', '$count', 'geocode_latitude', '$latitude_data'"
echo "put 'salmonella_table', '$count', 'geocode_longitude', '$longitude_data'"
count=$((count+1))
done | hbase shell
echo "done"
