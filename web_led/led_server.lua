-- Back end for html led

-- Config
local pin = 3            --> GPIO0
local value = gpio.LOW


function serve_html(conn)
	file.open("power_led.html")
	conn:send(file.read())
	file.close()
end

function set_led(value)
	gpio.write(pin, value)
end

print("Initialising")
print(wifi.sta.getip())
gpio.mode(pin, gpio.OUTPUT)
print("Creating server")
srv=net.createServer(net.TCP)
print("Start listening on port 80")
srv:listen(80,function(conn)
  conn:on("receive",function(conn,payload)
    print(payload)
	if string.find(payload, "/on") then
		set_led(gpio.HIGH)
		conn:send("on")
	elseif string.find(payload, "/off") then
		set_led(gpio.LOW)
		conn:send("off")
	elseif string.find(payload, "GET / HTTP") then
		serve_html(conn)
	else
        print("Sending hello")
		conn:send("<h1> Hello, NodeMcu.</h1>")
	end
  end)
  conn:on("sent",function(conn) conn:close() end)
end)
