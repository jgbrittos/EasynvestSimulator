Dado(/^(que )?estou na tela de (Formulário|Detalhes da Simulação)$/) do |x, screen|
    sleep(1)
    if screen == "Formulário"
        find_element(accessibility_id: "investedAmountLabel")
        find_element(accessibility_id: "maturityDateLabel")
        find_element(accessibility_id: "rateLabel")
    else 
        find_element(accessibility_id: "simulateAgainButton")
    end
end

E("digito {string} no campo {string}") do |value, field|
    field_element = find_element(accessibility_id: field)
    field_element.click
    field_element.send_keys(value)
end

Quando("aperto o botão {string}") do |button_text|
    if button_text == "Simular"
        find_element(accessibility_id: "simulateButton").click
        find_element(accessibility_id: "simulateButton").click
    else 
        find_element(accessibility_id: "simulateAgainButton").click
    end
end

Então("um alerta deve aparecer mostrando a seguinte {string}") do |message|
    if find_element(accessibility_id: message)
        find_element(accessibility_id: "Ok").click
        puts "Teste finalizado"
    else 
        puts "NOT FOUND"
    end
end