# Secured-SQL
One thing that i was always wish to develop was a way to secure all the procedures in the database.

As you know even the most efficients programs has some issues related with security, some are in the backend others in the client side, but almost no one take care of the DB side.

So that's why this project was developed.

You can add the functions to any part or even call it from your Backend and sanitize.

- SQL-INJECTIONS
- XSS
- EMPTY VALUES
- Tags with Attributes included!


## Examples


When you call this function into any statement, it's gonna filter each character and set the respective value according to the delimeters specified inside <b>str_clean()</b>

```sql
  select 'DEMO' as returns, str_clean('DEMO', true, true, true, true, true, true, true);
```

| returns | str_clean |
| ------ | ----------- |
| DEMO   | DEMO |
  

```  
  select 'DEMO123 demos' as returns, str_clean('<h1>DEMO</h1>123   demos', true, true, true, true, true, true, true);
```

| returns | str_clean |
| ------ | ----------- |
| DEMO123 demos   |``` <h1>DEMO</h1>123   demos ```|

```
  select 'DEMO123 456 7' as returns, str_clean('      DEMO    1234    56          7', true, true, true, true, true, true, true);
```

| returns | str_clean |
| ------ | ----------- |
| DEMO123 456 7   |```       DEMO    1234    56          7``` |

```
  select 'DEMOnds/5' as returns, str_clean('DEMO\n\ds/5', true, true, true, true, true, true, true);
```

| returns | str_clean |
| ------ | ----------- |
| DEMOnds/5   | ```DEMO\n\ds/5``` |

```
  select '¿Is this a demo?' as returns, str_clean('&iquest;Is this a demo?', true, true, true, true, true, true, true);
```

| returns | str_clean |
| ------ | ----------- |
| ¿Is this a demo?   | ```&iquest;Is this a demo?``` |


DONE:
- [x] MYSQL
- [x] POSTGRESQL
- [x] SQL-SERVER


TODO:
- [ ] ORACLE
- [ ] JSON VALIDATIONS
- [ ] ARRAYS VALIDATIONS


### Contributing

All contributions are welcome!

If you like this project then please click on the :star: it'll be appreciated or if you wanna add some functionality you can submite your pull request :)
or if you have an idea please let me know to my email: <luisalfonsocb83@gmail.com>.
