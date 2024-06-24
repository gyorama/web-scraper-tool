import Network.HTTP.Client
import Network.HTTP.Client.TLS (tlsManagerSettings)
import qualified Data.ByteString.Lazy.Char8 as L
import System.Environment (getArgs)

main :: IO ()
main = do

    args <- getArgs
    -- Assuming `url` is defined somewhere earlier
    let url = args !! 0
    
    -- Check and drop the URL prefix if it matches "http://" or "https://"
    let strippedUrl = if take 7 url == "http://"
                          then drop 7 url
                          else if take 8 url == "https://"
                                  then drop 8 url
                                  else url
    
    -- Create HTTP manager
    manager <- newManager tlsManagerSettings

    
    -- This is convenient but painful to look at

    request <- parseRequest ("http://" ++ strippedUrl);
    
    response <- httpLbs request manager
    
    L.putStrLn (responseBody response)