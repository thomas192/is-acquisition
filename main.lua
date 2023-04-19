SYSTEME = "propulsion"

s = sensor.attach("DHT11", pio.GPIO2)

function get_hum()
    return s:read("humidity")
end

function get_temp()
    return s:read("temperature")
end

function send_data()
    local hum = get_hum()
    local temp = get_temp()
    local timestamp = os.date("%Y/%m/%d*%X")

    local data_temp = timestamp .. ";" .. SYSTEME .. ";temperature;" .. temp .. ";degre"
    local data_hum = timestamp .. ";" .. SYSTEME .. ";humidite;" .. hum .. ";pourcent"

    client:publish("SMS_ACQ", data_temp, mqtt.QOS0, false)
    client:publish("SMS_ACQ", data_hum, mqtt.QOS0, false)

    print("Sent data: " .. data_temp)
    print("Sent data: " .. data_hum)
end

while true do
    send_data()
    tmr.delay(30)
end
