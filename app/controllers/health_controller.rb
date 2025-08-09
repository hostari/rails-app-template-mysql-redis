class HealthController < ApplicationController
  def check
    begin
      ActiveRecord::Base.connection.execute("SELECT 1")
      mysql_connected = true
    rescue => e
      mysql_connected = false
    end

    begin
      redis = Redis.new
      redis_connected = redis.ping == "PONG"
    rescue => e
      redis_connected = false
    end

    if mysql_connected && redis_connected
      render json: { status: "ok", mysql: "connected", redis: "connected" }, status: 200
    else
      render json: { 
        status: "error", 
        mysql: mysql_connected ? "connected" : "disconnected",
        redis: redis_connected ? "connected" : "disconnected"
      }, status: 404
    end
  end
end