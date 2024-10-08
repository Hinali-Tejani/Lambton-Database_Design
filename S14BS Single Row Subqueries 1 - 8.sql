SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES);

SELECT CUSTOMER_ID, CUSTOMER, (CREDIT_LIMIT - BALANCE) AS AVAILABLE_CREDIT
FROM CUSTOMERS
WHERE (CREDIT_LIMIT - BALANCE) > (SELECT AVG(CREDIT_LIMIT - BALANCE) FROM CUSTOMERS)
ORDER BY AVAILABLE_CREDIT DESC
FETCH FIRST 6 ROWS ONLY;

SELECT CUSTOMER_NAME, ORDER_ID, DAYS_TO_SHIP
FROM ORDERS
WHERE DAYS_TO_SHIP > (SELECT AVG(DAYS_TO_SHIP) FROM ORDERS)
ORDER BY DAYS_TO_SHIP DESC;

SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, JOB_TITLE, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_CODE = 'MA')
ORDER BY SALARY DESC
FETCH FIRST 8 ROWS ONLY;

SELECT JOB_CODE, JOB_TITLE, EMPLOYEE_NAME
FROM EMPLOYEES
WHERE JOB_CODE != (SELECT JOB_CODE FROM EMPLOYEES WHERE LAST_NAME = 'Evans')
ORDER BY JOB_TITLE, EMPLOYEE_NAME;

SELECT EMPLOYEE_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_CODE = (SELECT DEPARTMENT_CODE FROM DEPARTMENTS WHERE DEPARTMENT_NAME = 'Video Games')
ORDER BY LAST_NAME;

SELECT EMPLOYEE_NAME, JOB_CODE, JOB_TITLE
FROM EMPLOYEES
WHERE JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEES WHERE EMPLOYEE_ID = :ENTER_EMPLOYEE_ID)
ORDER BY LAST_NAME;

SELECT EMPLOYEE_NAME, DEPARTMENT_NAME, MONTHLY_SALARY
FROM EMPLOYEES
WHERE MONTHLY_SALARY > (SELECT MONTHLY_SALARY FROM EMPLOYEES WHERE LAST_NAME = 'Allan')
  AND DEPARTMENT_NAME = (SELECT DEPARTMENT_NAME FROM EMPLOYEES WHERE LAST_NAME = 'Harper')
ORDER BY MONTHLY_SALARY DESC;
