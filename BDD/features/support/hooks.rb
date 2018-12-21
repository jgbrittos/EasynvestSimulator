SCREENSHOTS_DIR_NAME = "screenshots"

# Isto será executado antes de cada cenário - Set Up
Before do
    puts "Set Up"
    $driver.start_driver
end

# Isto será executado depois de cada cenário - Tear Down
After do |scenario|
    puts "Tear Down"
    
    #take screenshot if test fails
    if scenario.failed?
        #if we dont have screnshots folder
        if !File.directory?(SCREENSHOTS_DIR_NAME)
            FileUtils.mkdir_p(SCREENSHOTS_DIR_NAME)
        end

        time_stamp = Time.now.strftime("%Y-%m-%d_%H.%M.%S")
        screenshot_name = time_stamp + ".png"
        screenshot_file = File.join(SCREENSHOTS_DIR_NAME , screenshot_name)
        $driver.screenshot(screenshot_file)
        #this embeds images at html report
        embed("#{screenshot_file}", "image/png")
    end
    
    # EXCLUIR ESTA LINHA NA HORA DOS TESTES GENERALIZADOS
    $driver.driver_quit
end

# this hook will be executed once when we starting test
AfterConfiguration do
    FileUtils.rm_r(SCREENSHOTS_DIR_NAME) if File.directory?(SCREENSHOTS_DIR_NAME)
end

=begin
   
This executes Before hook only to scenarios tagged with tag @tag
Before @tag do

end
    
=end

=begin
Before @login do    
    puts "BEFORE LOGIN"
    $driver.start_driver
    # ===========
    # FAZER LOGIN
    # ===========
    Dado que eu estou na tela inicial de onboarding
    E faço um swipe para a esquerda
        Quando aperto o botão "Pular"
        Então eu sou direcionado para a tela de login
        Quando João Brandão faz login
        Então ele é levado para a Wallet
    end
=end