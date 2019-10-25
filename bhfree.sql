SELECT  
        count(decode(bh.status,'free',block#,null)) "FREE Not currently in use",
        count(decode(bh.status,'flashfree',block#,null)) "FLASHFREE Free flash cache"
FROM    v$bh bh;