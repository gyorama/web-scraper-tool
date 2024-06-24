import Network.HTTP.Client
import Network.HTTP.Client.TLS (tlsManagerSettings)
import qualified Data.ByteString.Lazy.Char8 as L
import System.Environment (getArgs)

main :: IO ()
main = do

    args <- getArgs
    let url = args !! 0


    let strippedUrl = if take 7 url == "http://"
                          then drop 7 url
                          else if take 8 url == "https://"
                                  then drop 8 url
                                  else url
    
    
    manager <- newManager tlsManagerSettings

    request <- parseRequest ("http://" ++ strippedUrl);
    
    response <- httpLbs request manager
    
    L.putStrLn (responseBody response)