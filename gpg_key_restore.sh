for K in key-*.pdf; do
    dmtxread -e 8 ${K} >> secret_bytes.txt
done

cat secret_bytes.txt | paperkey --pubring ~/pub.gpg > secret.gpg
rm secret_bytes.txt
