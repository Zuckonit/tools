<?php
/**
 * send_mail
 * @param email from address
 * @param email from username
 * @param email to address
 * @param email subject name
 * @param email content
 * @param email signature
 * */
function send_mail($from, $f_name, $to, $subject, $message, $signature) {
    if(!filter_var($from, FILTER_VALIDATE_EMAIL)
                && !filter_var($to, FILTER_VALIDATE_EMAIL)) {
        return false;
    }
    $mail_body = $message . "\n" . $signature;
    $mail_head = array(
        "From: $f_name <$from>\r\n",
        "MIME-Version: 1.0\r\n",
        "Content-type: text/html; charset=UTF-8\r\n",
        "Reply-To: $f_name <$from>\r\n"
    );
    $mail_head = join("", $mail_head);
    $mail_param = "-f$from";
    return mail($to, $subject, $mail_body, $mail_head, $mail_param);
}

?>
