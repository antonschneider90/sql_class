/* BigQuery 'Easy': Return a list of all types of crimes in Austin. Table to use: `bigquery-public-data.austin_crime.crime` */

 SELECT DISTINCT(primary_type)
 FROM `bigquery-public-data.austin_crime.crime`
 
 /* BigQuery 'Easy': Return the number of murders in Austin for 2016 and later. Table to use: `bigquery-public-data.austin_crime.crime` */
 
 SELECT COUNT(*)
 FROM `bigquery-public-data.austin_crime.crime`
 WHERE LOWER(primary_type) = 'murder' AND year > 2015
 
 
 /* BigQuery 'Medium': Bike sharing in London - Return the name, longitude and latitude of the station with the longest individual rental duration. We're looking for the 'start name', i.e. the station where the bike was rented out, not returned. Tables to use: `bigquery-public-data.london_bicycles.cycle_stations` and `bigquery-public-data.london_bicycles.cycle_hire` */
 
  SELECT start_station_name, latitude, longitude
  FROM `bigquery-public-data.london_bicycles.cycle_stations` s
  LEFT JOIN `bigquery-public-data.london_bicycles.cycle_hire` h ON h.start_station_id = s.id
  ORDER by duration desc
  LIMIT 1
  
