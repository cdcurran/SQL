/* MySQL Assignment 1
Connect to JOURDATA in MySQL Workbench, Then open this file in MySQL Workbench. Rename it Firstname-Lastname-10-homework.sql. Work in this file to answer the questions.
Underneath each question below, create a new comment with the correct answer.  Underneath the answer -- NOT in a comment -- put the SQL query you used to derive the answer.
Use the table md_gov_race in the exercises database.  This is a single-table database of all campaign contributions to Republican Larry Hogan and Democrat Ben Jealous in the 2018 Maryland governor's race from January 2014 through June 2018, just before the primary election in June.
The data was downloaded from here https://campaignfinancemd.us/Public/ViewReceipts and cleaned.
Use the following documentation:
* unique_id: each record has a unique number to identify it. This is the table's "primary key". Each record represents one contribution.
* receiving_committee: each candidate has a "committee" set up to receive contributions.
* filing_period: the political cycles are broken up into different "periods", demarked by the time when candidates must report contributions to the state.
* contribution_date: the date on which a particular contribution was made.
* contributor_name, contributor_address, zip_code, state: details about the person who made the contribution.
* contributor_type: includes individuals, businesses, party committees and other types.
* contribution_type: includes credit cards, checks, loans, and more.
* contribution_amount: in dollars.
* employer_name: self-reported name of contributor's employer.  A lot of these values are blank.
* employer_occupation: self-reported occupation of contributor.  A lot of these values are blank.
*/

/* To submit: Rename the file firstname-lastname-SQL-Assignment-01.sql and upload to ELMS here: https://umd.instructure.com/courses/1259604/assignments/4811986 */

# 1. How many records are in the table?
/*ANSWER: 55327 rows of records*/
SELECT *
FROM exercises.md_gov_race;

# 2. What is the dollar amount of the largest dollar contribution from any source?  Who was it from, and who did it go to? What does the contribution type mean (link to a page or file on elections.maryland.gov where you find support for your answer)?
/*ANSWER: $68,133. From: Republican State Central Committee Of Maryland. To: Hogan Larry for Governor. "Coordinated In-Kind" means
"(1) A contribution given to a political committee in non-monetary form for services or
property; or
(2) A coordinated expenditure made on behalf of the candidate where the candidate
knows of and consents to the expenditure.
C. Value. For the purposes of the expenditure limit, the value of an in-kind contribution is the
fair market value of the item or service provided at the time of the contribution.
D. Expenditure Limit. Except as provided in COMAR 33.14.03.02 and §E of this regulation,
services provided to the eligible gubernatorial ticket for free or at a reduced cost are an inkind contribution and subject to the expenditure limit," according to https://elections.maryland.gov/laws_and_regs/documents/CCF_Proposed%20Regulations_Title%2014_07162015.pdf */
SELECT *
FROM exercises.md_gov_race
ORDER BY contribution_amount desc;

# 3. What was the largest dollar contribution amount to Ben Jealous? Who made it, and what type of contribution was it?
/*ANSWER: $50,000. Made by Ben Jealous. Candidate loan contribution. */
SELECT *
FROM exercises.md_gov_race
WHERE receiving_committee = "Jealous Ben Friends of"
ORDER BY contribution_amount desc;

# 4. Did Larry Hogan make any loans to his own campaign? Explain why you think this might be.
/*ANSWER: No. Larry Hogan did not make any loans to his campaign. Based on this data, it looks like Jealous received mostly indivdual contributions for his campaign, with $9004 being the highest amount other than his personal loan. Hogan, on the other hand, received large donations from businesses, PACS and in-kind support.*/
SELECT *
FROM exercises.md_gov_race
WHERE contribution_type = "candidate loan"


# 5. With the exception of a $9,004 contribution to Ben Jealous (which is possibly an error in the data), what is the dollar amount of the largest contribution from an individual donor.  Note: there are more than 200 individual contributions at this amount. For extra credit, do some quick Internet research and offer your best guess as to why this amount is the largest contribution.
/*ANSWER: $6000 is the largest individual contribution amount to the Jealous campaign. EXTRA CRED: A lot of those individual donors were from out of state. There's a cap of $6,000 for out of state donations.*/
SELECT *
FROM exercises.md_gov_race
WHERE receiving_committee = "Jealous Ben Friends of"
ORDER BY contribution_amount desc;

# 6. How many contributions are from Maryland?  How many contributions are from outside of Maryland, including other U.S. states and terrorities, foreign countries or contributions with no state listed?
/*ANSWER: 37685 contributors from MD. 17524 contributions were made outside MD.*/
SELECT *
FROM exercises.md_gov_race
WHERE state = "MD"
ORDER BY state;

SELECT *
FROM exercises.md_gov_race
WHERE state <> "MD"
ORDER BY state;

# 7. How many contributions for Larry Hogan came from outside of Maryland, and how many came from Maryland?  How many contributions for Ben Jealous came from outside of Maryland and how many came from Maryland?  Write four queries in total, each of which should use LIKE and wildcards to find contributions to Jealous or Hogan.  Then, using Excel or a calculator, calculate the percentage of each candidate's contributions that came from out of state.
/*ANSWER: Outside MD: 1584 for Hogan. IN MD: 34012 for Hogan. In MD for Jealous: 3673. Outside MD for Jealous: 15940.  90.96% Out of state for Jealous. 9.04% out of state for Hogan*/
SELECT *
FROM exercises.md_gov_race
WHERE state LIKE "MD%" AND receiving_committee LIKE "%Hogan%"
ORDER BY receiving_committee;

SELECT *
FROM exercises.md_gov_race
WHERE state NOT LIKE "MD%" AND receiving_committee LIKE "%Hogan%"
ORDER BY receiving_committee;

SELECT *
FROM exercises.md_gov_race
WHERE state LIKE "MD%" AND receiving_committee LIKE "%Jealous%"
ORDER BY receiving_committee;

SELECT *
FROM exercises.md_gov_race
WHERE state NOT LIKE "MD%" AND receiving_committee LIKE "%Jealous%"
ORDER BY receiving_committee;

# 8 The actress Jada Pinkett Smith gave money to one of the candidates.  List the candidate she gave to, her address, how much she gave, what she listed as her employer and the date.  Then list some of the clues in the data that tell you that the person described in the database as "Jada Pinkett Smith" is actually the actress and not just some random person with the same name, and how you would verify your hunch with web research.
/*ANSWER: She gave to the Jealous campaign. Her address is: 1880 Century Park E Los Angeles CA 90067. She gave $3,000. Arts and Entertainment is listed as her employment. She gave on 2017-09-28.
Clues from the data:
-her address listed is to the Will and Jada Smith Family Foundation, which is a philanthropic org.
-her job listed is in entertainment*/

SELECT *
FROM exercises.md_gov_race
WHERE contributor_name  LIKE "%Jada%"
ORDER BY contributor_name;

# 9. How many contributions were made to Larry Hogan in calendar year 2018?
/*ANSWER: 7584 contributions made to hogan in 2018*/
SELECT *
FROM exercises.md_gov_race
WHERE contribution_date BETWEEN "2018-01-01" AND "2018-12-31" AND receiving_committee = "Hogan Larry for Governor"
ORDER BY receiving_committee;

# 10. How many contributions were made to Ben Jealous on March 1, 2018 or later? How many were made on exactly March 2, 2018?
/*ANSWER: 6492 contributions made to Jealous on or after 3/1/18. 35 contributions were made on 3/2/18.*/
SELECT *
FROM exercises.md_gov_race
WHERE contribution_date >= "2018-03-01" AND receiving_committee = "Jealous Ben Friends of"
ORDER BY contribution_date;

SELECT *
FROM exercises.md_gov_race
WHERE contribution_date = "2018-03-02" AND receiving_committee = "Jealous Ben Friends of"
ORDER BY contribution_date;

# 11.  How many total contributions have a null value for employer_occupation?  How many total contributions have a non-null value for employer contribution?  What percentage of total contributions have a null value (use Excel or a calculator)?  Write a sentence describing your level of confidence in using the information in this database to describe, in aggregate, the occupations of people contributing to the campaign.
/*ANSWER: 32995 rows have a null value for empoyer_occupation. 22332 rows have a non-null value for empoloyer contribution. 59.63% of the total contributions have a null value.
My level of confidence is low in describing contributor's employment. There are useful fields that show what department a government employee who donated works in, but most of the non-null values listed are self-employed or retired. */
SELECT *
FROM exercises.md_gov_race
WHERE employer_occupation IS NULL
ORDER BY employer_occupation;

SELECT *
FROM exercises.md_gov_race
WHERE employer_occupation IS NOT NULL
ORDER BY employer_occupation;

# 12. A University of Maryland professor gave Ben Jealous a total of $6,000 in 15 separate contributions between September 2017 and June 2018, between $50 and $1000.  What is the name of the professor? What department does he teach in (you may need to do some internet research to find this out)? Please list the date and contribution amount for each contribution, along with all queries used to arrive at this information.
/* ANSWER: Norbert Hornstein. Norbert Hornstein is a Professor of Linguistics at the University of Maryland.
2017-09-23, $50
2017-11-04, $100
2017-12-26, $100
2/4/18, $100
2/21/18, $1000
3/14/18, $100
4/6/18, $100
4/9/18, $500
4/13/18, $600
4/27/18, $500
5/6/18, $250
5/10/18, $500
5/21/18, $500
5/26/18, $1000
6/9/18, $600*/
SELECT *
FROM exercises.md_gov_race
WHERE contribution_date Between "2017-09-01" AND "2018-06-30" AND receiving_committee = "Jealous Ben Friends of" AND employer_name IN ("UMD", "University of Maryland")
ORDER BY receiving_committee;

SELECT *
FROM exercises.md_gov_race
WHERE contribution_date Between "2017-09-01" AND "2018-01-31" AND contributor_name = "Hornstein Norbert"
ORDER BY receiving_committee;


# 13. How many contributions came from 21012 or 21401? Write a single query to do this.
/*ANSWER: 1307*/
SELECT *
FROM exercises.md_gov_race
WHERE zip_code = 21012 OR zip_code = 21401
ORDER BY zip_code;

# 14. Write a query that will return a table with contributions from people who listed their employer name as being retired or retired at least part of the time? Do not include contributions from people who work at communities or homes for people who are retired. And do not use the employer occupation field in this query.  List the number of records in the table here.
/*ANSWER: 6761 contributions*/
SELECT *
FROM exercises.md_gov_race
WHERE employer_name = "Retired" and employer_name IS NOT NULL
ORDER BY employer_name;