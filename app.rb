class App < Sinatra::Application
  configure do
    ENV["RACK_ENV"] = ENV["RACK_ENV"] || environment.to_s
  end
end
