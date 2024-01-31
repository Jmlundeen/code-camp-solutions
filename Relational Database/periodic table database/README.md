# Periodic Table Database

## Requirements
The goal of this project was to fix a given database, create a git repository, and write a bash script to query for elements in the database all while meeting the following requirements:
- [✅] 1. The `weight` column should be named 'atomic_mass'
- [✅] 2. The `melting_point` and `boiling_point` columns should have `_celcius` appended to the column name and not accept `null` values
- [✅] 3. The `symbol` and `name` columns should have `UNIQUE` constraints and not accept `null` values
- [✅] 4. `atomic_number` in `properties` table should be a `FOREIGN KEY` reference to `atomic_number` in `elements` table
- [✅] 5. Create a `types` table with a `type_id` Primary key and `type` columns
- [✅] 6. The `properties` table should have a `type_id` column with a `FOREIGN KEY` reference to `type_id` in the `types` table
- [✅] 7. The `properties` table should not have a `type` column
- [✅] 8. The `symbol` values in `elements` should have the first letter capitalized
- [✅] 9. Remove trailing zeros from `atomic_mass`
- [✅] 10. Add `Fluorine` and `Neon` to the database
- [✅] 11. Remove the element with atomic number `1000` from database
- [✅] 12. Create a `periodic_table` folder and initialize a git repository
- [✅] 13. Make at least five commits
- [✅] 14. The first commit should be `Initial commit` and others should start with `fix:`, `feat:`, `refactor:`, `chore:`, or `test:`
- [✅] 15. Create a bash script named `element.sh` that takes either an element name, symbol, or atomic number as an argument
- [✅] 16. If no argument is given, the script should return `Please provide an element as an argument.`
- [✅] 17. Elements output should be in the form `The element with atomic number <number> is <name> (<symbol>). It's a <type>, with a mass of <mass> amu. <name> has a melting point of <melting_point> celsius and a boiling point of <boiling_point> celsius.`

## Approach
I started this assigment by fixing the database. First, changing all of the column names and constraints. Then, I created the types table and added the foreign key reference to the properties table. There was a bit of a struggle figuring out how to properly format the trailing zeros. They suggested using `DECIMAL`, but this did not work after trying several sizes and decimal places. What finally worked was using the `REAL` datatype, giving the correct formatting. I then removed the type column from properties and fixed all the formatting issues in all of the columns. Next, I added the missing elements and removed the element with atomic number 1000. After fixing the database, I created a git repository and created my script file for my initial commit. I progressively made the script commiting changes incrementally. I first made the script handle no arguments, exiting the script and returning the proper message. Once that was finished, I added the database data retreival. When starting to work on printing the information I noticed an issue with my query and made a fix commit. After that, I finished the script information output and made my final feature commit. Lastly, I noticed my properties table still had the type column, which caused my query to need a fix after successfully removing. The project was then complete and passed all of the tests.


## Results
After fixing the database and creating the bash script, I was able to successfully query the database for elements using the element name, symbol, or atomic number. The script also handles invalid inputs and prompts the user to try again. The script also outputs the proper information for the element requested. The git repository was created and the commits were made incrementally, showing the progress of the program. The git repo for this is provided in the zip file and can be confirmed to see the progress of the script. The script and database met all of the requirements and passed all of the tests. The script and database are now ready to be used and maintained.