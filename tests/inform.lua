function postInfo()

http.get("http://localhost:8081/authentication", nil, function(code, data)
    if (code < 0) then
      print("HTTP request failed")
    else
      print(code, data)
    end
  end)



end