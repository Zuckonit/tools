<?php
/*=============================================================================
#     FileName: WanRequest.php
#         Desc: 
#       Author: Mocker
#        Email: Zuckerwooo@gmail.com
#      Version: 0.0.1
#   LastChange: 2013-09-03 14:02:37
#      History:
=============================================================================*/

/**
 * 200    OK
 * 400    bad request
 * 401    authentication required
 * 403    authentication forbidden
 */

define('DEFAULT_TIMEOUT',10);
define('DEFAULT_CONNECT_TIMMEOUT', 10);
define('DEFAULT_AGENT', "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)")
define('DEFAULT_HEADER', array('Content-Type: text/xml'))

function & curl_get_object($url) {
    global $curl_objects;
    if (empty($curl_objects)
        || !isset($curl_objects)
        || !is_object($curl_objects)) {
        $curl_objects[$url] = new CurlObject($url); 
    }
    return $curl_objects[$url];
}

class CurlObject {
    function CurlObject($url) {
        $this->$url = $url;
    }

    function init() {
        return curl_init($this->url);
    }
}

class WanRequest {
    private $url;
    private $curl;
    private $timeout;
    private $conn_timeout;
    private $agent;

    function WanRequest($url) {
        $this->url = $url;
        $this->curl = &curl_get_object($this->url).init();
    }

    function getAgent() {
        return $this->agent;
    }
    
    function setAgent($agent) {
        $this->agent = $agent;
    }

    function getUrl() {
        return $this->url;
    }

    function setUrl($url) {
        $this->url = $url;
    }

    function getCurl() {
        return $this->curl;
    }

    function getTimeout() {
        return $this->timeout;
    }

    function setTimeout($t) {
        $this->timeout = $t;
    }

    function getConnectTimeout() {
        return $this->conn_timeout;
    }

    function setConnectTimeout($ct) {
        $this->conn_timeout = $ct;
    }

    /**
     * from the wandisco api, we know that this will request xml data
     */
    function _request($method, $headers=Array(), $postdata=null) {
        $method = strtoupper($method);
        $array_methods = Array( 'GET', 'POST'); 

        //only GET and POST method can be used
        if (!in_array($method, $array_methods)) {
            return false;
        }

        if ($method == 'POST') {
            if (empty($postdata) || !isset($postdata)) {
                return false;      // if method is POST, postdata cannot be null
            }
            curl_setopt_array($this->curl,
                CURLOPT_POST => 1,
                CURLOPT_POSTFIELDS => $postdata
            );
        }

        $t   =  is_null($this->timeout) ? DEFAULT_TIMEOUT : $this->timeout;
        $ct  =  is_null($this->conn_timeout) ? DEFAULT_CONNECT_TIMEOUT : $this->conn_timeout;
        $h   =  !count($headers) ? DEFAULT_HEADER : $headers;
        $agt =  is_null($this->agent) ? DEFAULT_AGENT : $this->agent;
        curl_setopt_array($this->curl, 
            CURLOPT_URL => $this->url,
            CURLOPT_USERAGENT => $agt,
            CURLOPT_HTTPHEADER => $h,
            CURLOPT_TIMEOUT => $t,
            CURLOPT_CONNECTTIMEOUT => $ct
        );
        $result = curl_exec($this->curl);
        if (!$result) {
            //maybe use log here, then return false
            die('Error: "' . curl_error($this->curl) . '"- Code: ' . curl_errno($this->curl));
            //return false
        }
        curl_close($this->curl);
        return $result;
    }

    //wrapper for get request
    function request_get($headers=Array()) {
        return $this->_request('GET', $headers);
    }

    //wrapper for post request
    function request_post($postdata, $headers=Array()) {
        return $this->_request('POST', $headers, $postdata);
    }
}
?>
