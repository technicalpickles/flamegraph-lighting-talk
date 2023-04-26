def log(message)
  puts message
  puts caller(1).reverse
  puts
end

def hello
  log "hello"
  sleep 1
  world
end

def world
  log "world"
  sleep 2
  itsa("pickles")
end

def itsa(me)
  log "itsa me #{me}"
  sleep 3
end

def sup
  log "sup"
  sleep 4
end

def yall
  log "yall"
  sleep 1
end


log "main"

hello
sup
yall
