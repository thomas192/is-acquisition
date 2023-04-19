WIFI_SSID = "LAPTOP-KOQ8U3F6"
WIFI_PASSWORD = "AZERTY007_"
MQTT_HOST = "192.168.137.1"

-- WIFI
net.wf.setup(net.wf.mode.STA, WIFI_SSID, WIFI_PASSWORD)
net.wf.start()
while not net.connected() do
    print("[*] Connecting to wifi...")
    tmr.sleep(1)
end
print("Connected to wifi.")

-- MQTT
local client_id = string.format("%x", math.random(0, 0x100000000))
client = mqtt.client(client_id, MQTT_HOST, 1883, false)
local status, error = pcall(client.connect, client, "", "")
if status then
    print("Successfully connected to MQTT server")
else
    print("Failed to connect to MQTT server : " .. error)
end
