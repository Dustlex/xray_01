It's a simple matter of running your XRAY server in a container. There is an even simpler option, in another repository https://github.com/Dustlex/xray_02_compose.

1) You need to install docker beforehand

2) Download the repository to a separate directory and go into it:
 mkdir ~/xray && cd ~/xray/
 git clone https://github.com/Dustlex/xray_01.git
 cd ~/xray/xray_01/

3) Build the build with the command:

   docker build -f dockerfile -t xray_server:01 .

4) Without leaving the docker directory, run the run as in the example below, but it is necessary to change the variables specified with -e:
- UUID variable (can be generated in any UUID generator, it will be used for VLESS connection)
- PASS variable (this is the password for shadowsocks, must be 12 characters (provided you don't change the 128-bit encryption in config.json) , base64 encoded)
   + you can encode the password "pipidorka123LEXP" with the command echo -n "pipidorka123LEXP" | base64. 
   + the obtained value should be specified in the variable and when connecting in the client during shadowsocks connection.

- The final run will look like this: 
   
  docker run --name xray-01 --network host -e PASS=cGlwaWRvcmthMTIzTEVYUA== -e UUID=d2adee51-6ced-11ee-b962-0242ac120002 -d xray_server:01

- You can verify the startup via docker logs xray-01

As a client, I recommend using Nekoray https://github.com/MatsuriDayo/nekoray/releases/download/3.23/nekoray-3.23-2023-10-14-windows64.zip.

To connect, select Server - new profile - VLESS and fill in the window:
 + Name - any
 + Address - the domain that you directed to the server where you deployed the container.
 + Port - 443
 + UUID - the one you specified in the variable via -e during docker run
 + FLOW - xtls-rprx-vision
 + Transport - tcp
 + Security - tls
 + Packet encoding - xudp
 + Network settings - check the box - allow insecure connection (encryption will be ok, but with a certificate that we issued in the container ourselves, not from a trusted center).
Leave everything else as it is. 

Turn on, and choose either system proxy mode or TUN mode (the latter also creates a virtual network adapter in windows, to which you can configure connection of other adapters).



Это простой запуск своего XRAY сервера в контейнере. Есть вариант еще проще, в другом репозитории https://github.com/Dustlex/xray_02_compose

1) Предварительно необходимо установить docker

2) Cкачать репозиторий в отдельную директорию и зайти в нее:
 mkdir ~/xray && cd ~/xray/
 git clone https://github.com/Dustlex/xray_01.git
 cd ~/xray/xray_01/

3) Собрать билд командой:

   docker build -f dockerfile -t xray_server:01 .

4) Не выходя из деиректории, запускаем run как в примере ниже, но необходимо изменить переменные указываемые через -e:
- Переменную UUID (можно сформировать в любом UUID генераторе, она будет использована для VLESS подключения)
- Переменную PASS (это пароль для shadowsocks, должен состоять из 12-ти символов (при условии что вы не измените 128-битное шифрование в config.json) , закодированный в base64)
   + закодировать пароль "pipidorka123LEXP" можно командой echo -n "pipidorka123LEXP" | base64 
   + полученное значение надо указать в переменную и при подключении в клиенте  при shadowsocks подключении

- Итоговый запуск будет выглядеть так: 
   
  docker run --name xray-01 --network host -e PASS=cGlwaWRvcmthMTIzTEVYUA== -e UUID=d2adee51-6ced-11ee-b962-0242ac120002 -d xray_server:01

- Проверить запуск можно через docker logs xray-01

В качестве клиента, рекомендую использовать Nekoray https://github.com/MatsuriDayo/nekoray/releases/download/3.23/nekoray-3.23-2023-10-14-windows64.zip

Для подключения, выбираем Сервер - новый профиль - VLESS и в окне заполняем:
 + Имя - любое
 + Адрес - домен который вы направили на сервер где разворачивали контейнер
 + Порт - 443
 + UUID - тот что вы указали в переменной через -e при docker run
 + FLOW - xtls-rprx-vision
 + Транспорт - tcp
 + Безопасность - tls
 + Кодирование пакетов - xudp
 + Настройки сети - ставим галочку - разрешить небезопасное подключение (шифрование будет ок, но с сертификатом что мы выпустили в контейнере сами, а не из доверенного центра)
Все остальное оставляем как есть. 

Включаем, и выбираем либо режим системного прокси, либо режим TUN (последний в т.ч. создает виртуальный сeтевой адаптер в windows , к которому можно настроить подключение других адаптеров).
