/* 収切 敗呪
ROUND : 働舛 切鹸呪拭辞 鋼臣顕.
ROUND(企雌): 社呪繊税 湛腰属 切軒研 鋼臣顕背獄顕
ROUND(企雌, 社呪繊 切鹸呪)
    社収繊 切軒呪亜 丞呪析 井酔 : 社呪繊 奄層 神献楕生稽 切鹸呪幻鏑 戚疑廃 及拭 益 陥製 葵聖 鋼臣顕.
    社収繊 切軒呪亜 製呪析 井酔 : 社呪繊 奄層 図楕生稽 切鹸呪幻鏑 戚疑廃 及拭 益 切軒 葵聖 鋼臣顕.

TRUNC : 働舛 切鹸周拭辞 設虞鎧辞 獄顕
MOD : 脊径閤精 呪研 蟹勧 蟹袴走 葵幻聖 窒径敗
*/

-- ROUND: 社呪繊 切軒呪亜 丞呪析 井酔税 戚疑 井稽
select 99.7564, ROUND (98.7654), round (98.7654,2) from dual; -- 社呪繊 奄層 2切軒 神献楕 戚疑, 益 板 葵聖 石生檎 5亜 蟹身.
                                                              -- 益 衣引 98.77戚 窒径喫.そそそそそそそそそそ


-- ROUND: 社呪繊 切軒呪亜 製呪析 井酔税 戚疑 井稽
select ROUND (98.7654,-1) from dual; -- 社呪繊 奄層 1切軒幻鏑 図楕生稽 戚疑馬檎,
                                     --  廃切軒呪昔 8聖 鋼臣顕馬食 100税 葵聖 窒径 敗.
select ROUND (98.7654,-3) from dual; -- 社呪繊 奄層 3切軒幻鏑 図楕生稽 戚疑馬檎,
                                     -- 室切軒呪研 左壱 鋼臣顕馬澗汽, 0戚糠稽 鋼臣顕馬走 公馬壱 蟹袴走 陥 獄形獄顕.

-- TRUNC: ROUND人 拙疑 号縦戚 疑析敗
select 98.7654 据沙収切, TRUNC(98.7654) as "turnc 奄沙旋遂", 
TRUNC(98.7654,2)as "turnc 2脊径", TRUNC(98.7654,-1) as "turnc -1 脊径"  from dual;

-- MOD (企雌, 蟹刊澗 呪) : 企雌聖 蟹刊嬢辞 蟹袴走 葵幻 窒径敗.
SELECT mod (31,2), mod(31, 5), mod(31,8) from dual;

select *  from employee;

select salary, mod (salary, 300) from employee;

-- employee 砺戚鷺拭辞 紫据腰硲亜 側呪昔 昔据級幻 窒径敗

SELECT ename 失誤, eno 紫据腰硲
FROM employee
where mod(eno, 2) = 0;

select 12345.6789, round (12345.6789), round (12345.6789, -3) from dual;
 
/* 劾促 敗呪

sysdate: 獣什奴拭 煽舌吉 薄仙 劾促研 窒径敗.
month_between: 砧 劾促 紫戚亜 護鯵杉昔走研 鋼発敗.
add_month: 働舛 劾促拭 鯵杉呪研 希廃陥.
next_day: 働舛 劾促拭 置段稽 亀掘馬澗 昔切稽 閤精 推析税 劾促研 鋼発敗
*/

-- sysdate: 切重 獣什奴 奄層税 鰍杉析聖 窒径敗.
select sysdate from dual;

-- sysdate ‐ n: n析 幻鏑 蒋 暁澗 及税 劾促研 窒径敗.
select sysdate - 1 嬢薦劾促 , sysdate 神潅劾促, sysdate + 1 鎧析劾促 from dual;

-- 原濁亜走稽 劾促拭 淫恵吉 敗呪虞檎, 蒋識 sysdate坦軍 n 析聖 蓄亜 暁澗 薦須 亜管敗.
select ename 失誤,hiredate 脊紫析, hiredate +365 脊紫1爽鰍 from employee;

-- 唖 紫据級税 悦巷廃 鯵杉 呪 姥馬奄.
SELECT ename 失誤, hiredate 脊紫析, trunc((sysdate - hiredate)/30) 悦紗鯵杉呪 from employee;

-- months_between(data1, data2): data1引 data2 紫戚税 鯵杉呪研 窒径
SELECT ename 失誤, hiredate 脊紫析, trunc(months_between (sysdate, hiredate)) 悦紗鯵杉呪 from employee;

-- 唖 紫据級税 悦紗 鰍呪 姥馬奄.
SELECT ename 失誤, hiredate 脊紫析, trunc((sysdate - hiredate)/365) 悦紗鰍呪 from employee;

-- 働舛 杉拭 脊紫廃 昔据級 姥馬奄: 12杉 脊紫切 窒径
SELECT ename 失誤, hiredate 脊紫析 from employee where hiredate like '%/12/%';
SELECT ename 失誤, hiredate 脊紫析 from employee where hiredate ('month')= 12;

-- trunck研 劾促拭 旋遂馬奄 : 01析戚蟹 01杉, 01鰍 去税 段奄葵生稽 窒径喫
select hiredate, trunc(hiredate, 'month') 脊紫杉 from employee;

-- round研 劾促拭 旋遂馬奄 : 奄娃税 箭鋼 戚雌戚 鞠檎 鋼臣顕 鞠辞 臣形獄顕.
select hiredate, round(hiredate, 'year') 脊紫杉 from employee;

-- 笑紫廃 板 6鯵杉 走貝 獣繊聖 窒径敗
SELECT hiredate, add_months (hiredate,6) from employee;


--next_day (data, '推析'): date税 亀掘馬澗 推析拭 企廃 劾促研 窒径馬澗 敗呪
select sysdate 神潅, next_day(sysdate, '塘推析') as"戚腰爽 塘推析" from dual;

--last_day(date): date拭 級嬢娃 含税 原走厳 劾促.
select hiredate, last_day(hiredate) from employee; --脊紫杉税 原走厳 劾聖 啄嬢捜

/* 莫痕発 敗呪 (古酔 掻推敗)

TO_cHAR:  劾促莫 暁澗 収切莫 汽戚斗研 庚切莫生稽 痕発馬澗 敗呪
TO_DATE: 庚切莫聖 劾促莫生稽 痕発馬澗 敗呪
TO_NUMBER: 庚切莫聖 収切莫生稽 痕発馬澗 敗呪

*/

-- 劾促 敗呪 紫遂馬奄
-- TO_CHAR(date, 'yymmdd') : 森薦人 旭戚 切政罫惟 竺舛 亜管敗
select ename 失誤, hiredate 脊紫析, to_char(hiredate, 'yyyymmdd') 脊紫析2 from employee;
select ename 失誤, hiredate 脊紫析, to_char(hiredate, 'yymmdd') 脊紫析2 from employee;
select ename 失誤, hiredate 脊紫析, to_char(hiredate, 'yydd') 脊紫析2 from employee;
select ename 失誤, hiredate 脊紫析, to_char(hiredate, 'yd') 脊紫析2 from employee;

--劾促亀 脊径 亜管敗
select ename 失誤, to_char(hiredate, 'DaY') 脊紫推析 from employee;
select ename 失誤, to_char(hiredate, 'DY') 脊紫推析 from employee; --'DY'澗 推析税 鉦嬢

-- 薄仙 獣什奴税 神潅 劾促研 窒径馬壱 獣娃 段猿走 窒径敗.
select sysdate 神潅, to_char(sysdate, 'dy') 推析, to_char(sysdate,'yymmdd hh:mi:ss') from dual;

desc employee;

select hiredate
from employee;

SELECT ename, hiredate, to_char(hiredate, 'yyyy-mm_dd hh:mi:ss') from employee;

/* TO_CHAR拭辞 収切人 淫恵吉 莫縦

0: 切鹸呪研 蟹展鎧悟 切鹸呪亜 限走 省聖 井酔 0生稽 辰嵩艦陥.
9: 切鹸呪研 蟹展鎧悟 切鹸呪亜 限走 省聖 井酔拭澗 辰酔走 省柔艦陥,
L: 唖 走蝕紺 搭鉢 奄硲研 窒径
. : 社呪繊生稽 妊薄
, : K 舘是税 姥歳切

*/

-- to_char(鎮軍誤, 'L+切鹸呪): 鎮軍税 収切研 窒径馬鞠, L(唖厩 搭鉢奄硲 窒径)引 敗臆
--                           収切亜 託赤澗 幻鏑, 6切軒研 窒径馬壱, 幻鉦 切鹸呪研
--                           段引馬澗 井酔拭澗 辰酔走 省澗 辛芝聖 識澱敗.
SELECT ename 失誤, salary 杉厭, to_char(salary, 'L999,999') from employee;
SELECT ename 失誤, salary 杉厭, to_char(salary, 'L000,000') from employee;

-- 買遂廃 切鹸呪研 段引馬檎 乞窮 牒戚 ###生稽 亀壕鞠嬢辞 窒径喫. 戚闇 0引 9亜 疑析敗.
SELECT ename 失誤, salary 杉厭, to_char(salary, 'L999') from employee;
SELECT ename 失誤, salary 杉厭, to_char(salary, 'L000') from employee;

-- to_date('char', 'fornat'): 劾促 莫縦生稽 穿発
SELECT SYSDATE, trunc((SYSDATE - to_date('20000101', 'yyyymmdd'))/365) as "鰍呪(幻)" FROM dual;

select sysdate 獣拙析,to_date('201010') 曽戟析, trunc((sysdate - to_date('201010'))/30) 社推鯵杉 from dual;

select hiredate from employee;

select ename 失誤, hiredate 脊紫析 from employee
where hiredate = '81/02/22';

select  ename,  hiredate 
from employee
where hiredate = to_date ('1981-02-22', 'yyyy-mm-dd') ;

-- 2000鰍 12杉 25析採斗 走榎猿走 恥 護含戚 走概澗走

select trunc((sysdate - to_date('2000-12-25'))/30) 井引鯵杉呪 from dual;

-- to_number: number 汽戚斗 展脊生稽 痕発
select '100,000' - '50,000' from dual;

select to_number('100,000', '999,999') - to_number ('50,000', '999,999') as 暗什硯儀 from dual;


-- NVL 敗呪: null聖 陥献 葵生稽 帖発背爽澗 敗呪
select ename, commission from employee;

select ename 失誤, nvl(commission, 0)左格什 from employee;

select ename 失誤, nvl(manager, 1111) "送紗雌紫 紫腰" from employee;

--NVL 敗呪2

--nvl2 (Expr1, expr2, expr3): expr1 != null => expr2 窒径
--                            expr1 == null => expr3 窒径

select salary, commision from employee;

--nvl 敗呪稽 尻裟 域至馬奄

select ename 失誤, salary "       杉厭        ",nvl(commission,0) "       左格什        " , (salary*12 + nvl(commission,0)) 
"       尻裟       " from employee;

--nvl2 敗呪稽 尻裟 域至馬奄
select ename 失誤, salary "       杉厭        ",nvl(commission,0) "       左格什        " ,
nvl2(commission,(salary*12)+commission, salary*12)"       尻裟       " 
from employee;

-- nullif : 砧 妊薄縦聖 壕嘘背辞 疑析廃 井酔, null聖 鋼発馬壱 疑析馬走 省聖 井酔拭幻 
--          湛腰属 妊薄縦聖 鋼発敗.

select nullif('A','A'), nullif('A','B') from dual; -- 蒋 nullif澗 null, 急 nullif澗 蒋税 葵聖 鎧捜

-- nullif人 nvl2税 肇杯 紫遂 -> 析帖 毒偽奄
select nvl2(nullif('A','A'),'災析帖','析帖' ), nullif('A','B') from dual;


/* coalesce 敗呪

coalesce (expr1,expr2,expr3,....expr(n));
疎著採斗 授託旋生稽 端滴背辞 null葵戚檎 酔著生稽 薪移亜檎辞 亜舌 胡煽 蟹神澗 null戚須税 葵聖 窒径背捜.

*/

select coalesce ('abc','bcd','def','efg','fgh') from dual;
select coalesce (null,null,'def','efg','fgh') from dual;
select coalesce (null,null,null,'efg',null) from dual;

--coalesce敗呪研 醗遂廃 尻裟 域至
SELECT ename, salary 杉厭, nvl(commission,0) 左格什, coalesce(commission + salary*12, salary*12, 0) 尻裟 from employee;

/* decode 敗呪

DECODE (妊薄縦, 繕闇1, 衣引1,
               繕闇2, 衣引2,
               繕闇3, 衣引3,
               奄沙衣引n
        )



*/

select ename 失誤, dno 採辞腰硲, decode(dno, 10, 'Accounting',
                                           20, 'Research',
                                           30, 'Sales',
                                           40, 'Operation',
                                           'Default') as 採辞誤
from employee;

--dno 町軍戚 10腰 採辞 + 300 / 20腰 採辞 +500 / 30腰 採辞 + 500/
                          
select ename 失誤, dno 採辞腰硲,salary "昔雌 穿 杉厭", decode(dno, 10, 300,
                                                               20, 500,
                                                               30, 700,
                                                               'Default') "昔雌衝",

                                                   decode(dno, 10, salary + 300,
                                                               20, salary + 500,
                                                               30, salary + 700,
                                                               'Default') "昔雌 板 杉厭"
from employee;             


-- case: 
~ else if, else if ~~
/*

case 妊薄縦 when 繕闇1 then 衣引1
           when 繕闇2 then 衣引2
           when 繕闇3 then 衣引3
           else 衣引n
           end
*/

select ename 失誤, dno 採辞腰硲, case when dno = 10 then 'Accounting'
                                    when dno = 20 then 'Research'
                                    when dno = 30 then 'Sales'
                                    when dno = 40 then 'Operation'
                                    else 'Default'
                                    end as 採辞誤

from employee
order by dno;