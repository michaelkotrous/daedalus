# Daedalus
This project converts csv exports of select tables from the NTSB's eADMS (enhanced Accident Data Management System) dataset to MySQL and joins data on the aircraft, pilots, weather conditions and other circumstances to create a single dataset on General Aviation accidents between 1982 and 2017.

Note: The latest export of the Microsoft Access database reflects eADMS data as of **May 1, 2017.** The full dataset is updated the first day of each month.

## Mission
The National Transportation Safety Board (NTSB) collects extensive data on all aviation accidents. By law, any accident involving an aircraft operated with the intent of flight must be reported to the NTSB for investigation. The rich data is made available to researchers and the public on paper, but the data is difficult to find in practice and, when found, is only given in Microsoft Access (MDB) format.

The goal of the Daedalus project is to provide inspiration and even maybe the tools needed by researchers to convert and merge the NTSB eADMS dataset to a format that is better suited for answering their research questions regarding aviation accidents and incidents.

## Using Daedalus
The first iteration of this repository will convert six eADMS tables into MySQL tables, merge those tables, and then export a dataset listing aircraft, pilot, time, and weather information on all General Aviation accidents between Jan. 1, 1982 and May 1, 2017 that involved fixed-wing airplanes.

### Generating General Aviation Accident Data
Create a MySQL database of any name of your choosing, and a database user with all privileges. See the subsection "System Requirements" below for more on installing MySQL. Then in Terminal:

```bash
cd /path/to/daedalus
./aircra.sh -u mysql_dbuser -d mysql_dbname
```

All the options available to you when running the shell script `aircra.sh` are:

```
-d (required): mysql database name that must be created before running command.
-u (required): mysql user that must have all privileges for database specified in option -d.
-h (optional): database host name. Default value is 'localhost'.
-p (optional): Set this option to FALSE or F if password is not required for the mysql user. By default, aircra.sh expects a password for your mysql user.
```

You will be prompted for the password of the MySQL user. Once entered, the remainder of the scripts will run, and you will finish with a csv export of the General Aviation accident dataset in the Daedalus project directory.

**Note:** The `aircra.sh` shell script also accepts option `-h` for defining the database host. That option defaults to `localhost`, but you are free to override that value if necessary.

### System Requirements
The current version of this repository consists simply of csv data sheets, a shell script, and sql scripts that handle importing, merging, and exporting a dataset on General Aviation accident data. Thus, you only need a utility like Terminal to run the shell script and MySQL to handle the data conversion.

If you're not sure if you have MySQL installed on your server or device, check with this command in Terminal:

```bash
which mysql
```

This command will return a path to the executable file, if MySQL is properly installed.

I won't lay out one specific option for installing MySQL; a few Google searches will turn up helpful documentation for doing so. You can use a package manager like [Homebrew](https://brew.sh/) to install and update MySQL, or you can use [MAMP](https://www.mamp.info/en/) to access a MySQL server complete with PhpMyAdmin.

## How You Can Contribute
Daedalus is far from its ideal state; my hope is to provide a script that will download the latest version of the eADMS dataset, convert the MDB tables to MySQL, and then merge the MySQL tables to create a rich, working dataset that can be exported to a format friendly to R, Stata, and other statistical packages. Here's some tasks that you can submit a pull request for, if you are up to doing so:

- [ ] Download the latest version of the eADMS dataset with wget or curl.
- [ ] Update the csv files in ntsb_mdb_export directory to reflect the latest release.
- [ ] Convert all tables in the MDB format of the eADMS dataset, or csv exports of those tables, to MySQL tables. This [sample script](https://app.ntsb.gov/avdata/eadmspub.sql.txt) provided by the NTSB that promises to create a SQL Server version of the database was a useful guide as I worked with the six tables I successfully converted.
- [ ] Share your publications that use this repository or the eADMS dataset by updating this README file.
- [ ] Add file detailing all the variables available in the NTSB eADMS dataset. The existing [list of variables](https://app.ntsb.gov/avdata/eadmspub.pdf) nor any other NTSB documentation offers such details.

## Publications Using Daedalus Project
There are no publications that use this tool, yet.
