-- 1.1 Create View C15V1
CREATE VIEW C15V1 AS
SELECT 
    D.DEPARTMENT_NAME AS dept_name,
    E.LAST_NAME AS lname,
    E.FIRST_NAME AS fname,
    E.HIRE_DATE,
    E.MONTHLY_SALARY AS salary
FROM 
    DEPARTMENTS D
JOIN 
    EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE 
    E.HIRE_DATE >= '2008-01-01';

-- Query against the view
SELECT * FROM C15V1
ORDER BY dept_name, lname;


-- 1.2 Query against C15V1
SELECT * FROM C15V1
WHERE dept_name IN ('Home Theater', 'Video Games')
ORDER BY dept_name, lname;


-- 1.3 Query against base tables
SELECT 
    D.DEPARTMENT_NAME AS dept_name,
    E.LAST_NAME AS lname,
    E.FIRST_NAME AS fname,
    E.HIRE_DATE,
    E.MONTHLY_SALARY AS salary
FROM 
    DEPARTMENTS D
JOIN 
    EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE 
    E.HIRE_DATE >= '2008-01-01'
AND 
    D.DEPARTMENT_NAME IN ('Home Theater', 'Video Games')
ORDER BY dept_name, lname;


-- 2.1 Create View C15V2
CREATE VIEW C15V2 AS
SELECT 
    E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE_NAME,
    J.JOB_CODE,
    J.JOB_TITLE,
    E.MONTHLY_SALARY * 12 AS YEARLY_SALARY,
    J.MAX_SALARY
FROM 
    EMPLOYEES E
JOIN 
    JOBS J ON E.JOB_ID = J.JOB_ID
WHERE 
    J.MAX_SALARY > 50000;

-- Verify the view
SELECT * FROM C15V2
ORDER BY YEARLY_SALARY DESC;


-- 2.3 Query against C15V2
SELECT 
    EMPLOYEE_NAME,
    MAX_SALARY,
    YEARLY_SALARY,
    MAX_SALARY - YEARLY_SALARY AS SALARY_DIFFERENCE
FROM 
    C15V2
WHERE 
    JOB_TITLE = 'Department Manager'
ORDER BY SALARY_DIFFERENCE DESC;


-- 2.4 Query against base tables
SELECT 
    E.FIRST_NAME || ' ' || E.LAST_NAME AS EMPLOYEE_NAME,
    J.MAX_SALARY,
    E.MONTHLY_SALARY * 12 AS YEARLY_SALARY,
    J.MAX_SALARY - (E.MONTHLY_SALARY * 12) AS SALARY_DIFFERENCE
FROM 
    EMPLOYEES E
JOIN 
    JOBS J ON E.JOB_ID = J.JOB_ID
WHERE 
    J.JOB_TITLE = 'Department Manager'
AND 
    J.MAX_SALARY > 50000
ORDER BY SALARY_DIFFERENCE DESC;


-- 3.1 Create View C15V3
CREATE VIEW C15V3 AS
SELECT 
    E.EMPLOYEE_ID AS emp_id,
    E.FIRST_NAME || ' ' || E.LAST_NAME AS employee_name,
    D.DEPARTMENT_NAME AS department_name,
    E.MANAGER_ID AS mgr_id,
    M.FIRST_NAME || ' ' || M.LAST_NAME AS manager_name
FROM 
    EMPLOYEES E
LEFT JOIN 
    DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN 
    EMPLOYEES M ON E.MANAGER_ID = M.EMPLOYEE_ID;

-- Query against the view
SELECT * FROM C15V3
ORDER BY emp_id
FETCH FIRST 10 ROWS ONLY;


-- 4.1 Create View C15V4
CREATE VIEW C15V4 AS
SELECT 
    D.DEPARTMENT_NAME AS dept_name,
    MIN(E.MONTHLY_SALARY) AS lowest_salary,
    MAX(E.MONTHLY_SALARY) AS highest_salary,
    AVG(E.MONTHLY_SALARY) AS avg_monthly_salary
FROM 
    DEPARTMENTS D
LEFT JOIN 
    EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
GROUP BY 
    D.DEPARTMENT_NAME;

-- Query against the view
SELECT * FROM C15V4
ORDER BY dept_name;


-- 4.3 Query against C15V4
SELECT 
    dept_name,
    avg_monthly_salary
FROM 
    C15V4
WHERE 
    avg_monthly_salary IS NOT NULL
AND 
    avg_monthly_salary > 4000.00
ORDER BY dept_name;


-- 5.1 Create View C15V5
CREATE VIEW C15V5 AS
SELECT 
    C.CUSTOMER_NAME,
    O.ORDER_DATE,
    O.ORDER_ID,
    P.PRODUCT_CODE,
    P.QUANTITY,
    P.PRICE,
    P.DESCRIPTION
FROM 
    CUSTOMERS C
JOIN 
    ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
JOIN 
    ORDER_ITEMS P ON O.ORDER_ID = P.ORDER_ID;

-- Query against the view
SELECT * FROM C15V5
ORDER BY CUSTOMER_NAME, ORDER_DATE, PRODUCT_CODE;


-- 6.1 Create View C15V6
CREATE VIEW C15V6 AS
SELECT 
    C.CATEGORY_NAME,
    P.PRODUCT_CODE,
    P.DESCRIPTION AS product_description,
    O.ORDER_ID,
    O.ORDER_DATE,
    P.QUANTITY,
    P.PRICE
FROM 
    CATEGORIES C
JOIN 
    PRODUCTS P ON C.CATEGORY_ID = P.CATEGORY_ID
JOIN 
    ORDER_ITEMS OI ON P.PRODUCT_CODE = OI.PRODUCT_CODE
JOIN 
    ORDERS O ON OI.ORDER_ID = O.ORDER_ID
WHERE 
    C.CATEGORY_NAME IN ('Small Appliances', 'Sporting Goods');

-- Query against the view
SELECT * FROM C15V6;


-- 6.3 Query against C15V6
SELECT 
    PRODUCT_CODE,
    product_description,
    ORDER_ID,
    PRICE AS price_paid
FROM 
    C15V6
WHERE 
    PRICE > 1000.00
ORDER BY PRODUCT_CODE, ORDER_ID;


-- 6.4 Query against C15V6 for total order amount
SELECT 
    ORDER_ID,
    SUM(PRICE * QUANTITY) AS total_order
FROM 
    C15V6
GROUP BY 
    ORDER_ID
HAVING 
    SUM(PRICE * QUANTITY) > 700.00;