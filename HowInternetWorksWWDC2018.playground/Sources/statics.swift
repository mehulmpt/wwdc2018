public var learnData: [String: [[String: String]]] = [
    "http": [
        [
            "image": "you",
            "tooltip": "This is you. Hello!",
            "heading": "LETS GO!",
            "spriteFrames": "8",
            "delay": "0.1"
        ],
        [
            "image": "computer",
            "tooltip": "You're about to\n open http://apple.com\n on your computer to\n make a search",
            "heading": "Making A HTTP Request"
        ],
        [
            "image": "isp",
            "tooltip": "This request is forwarded to your\n Internet Service Provider.\n This is important because your\n computer does not know what\n \"apple.com\" is",
            "heading": "DNS Lookup"
        ],
        [
            "image": "dnsapple",
            "tooltip": "DNS Lookup is performed\n by your ISP and your ISP will\n return you an IP address of the website\n (here, apple.com)",
            "heading": "Actual Site IP Address"
        ],
        [
            "image": "dnsservertalk",
            "tooltip": "Now that you have IP\n address for the website you want, your\n computer can make a request to that computer\n (IP address) and tell what it needs.\n The web server will send you back\n HTML documents.",
            "heading": "Downloading Web Page"
        ],
        [
            "image": "computerapple",
            "tooltip": "This document is\n downloaded by your browser\n and showed to you!",
            "heading": "Final Result"
        ]
    ],
    
    
    "https": [
        [
            "image": "you",
            "tooltip": "This is you. Hello!",
            "heading": "LETS GO!",
            "spriteFrames": "8",
            "delay": "0.1"
        ],
        [
            "image": "computer",
            "tooltip": "You're about to\n open https://apple.com\n on your computer to\n make a search",
            "heading": "Making A HTTPS Request"
        ],
        [
            "image": "isp",
            "tooltip": "This request is forwarded to your\n Internet Service Provider.\n This is important because your\n computer does not know what\n \"apple.com\" is",
            "heading": "DNS Lookup"
        ],
        [
            "image": "dnsapple",
            "tooltip": "DNS Lookup is performed\n by your ISP and your ISP will\n return you an IP address of the website\n (here, apple.com)",
            "heading": "Actual Site IP Address"
        ],
        [
            "image": "dnsservertalk",
            "tooltip": "Now that you have IP\n address for the website you want, your\n computer can make a request to that computer\n (with the IP address) and perform\n a \"SSL\" handshake.",
            "heading": "Connecting to server"
        ],
        [
            "image": "handshake",
            "tooltip": "SSL Handshake involves exchanging\n of certain public/private keys\n by client/server so that your\n communication is secure.",
            "heading": "SSL Handshake",
            ],
        [
            "image": "handshake-0step",
            "tooltip": "The first step is actually\n exchanging keys in such a way\n that anyone who is eavesdropping your connection\n with server should not be able to read\n future messages. Let assume an attacker\n is eavesdropping connection\n between you and server.",
            "heading": "SSL Encryption",
            "spriteFrames": "29",
            "delay": "0.1"
        ],
        [
            "image": "hellossl1",
            "tooltip": "Your computer sends a 'Hello' message to\n server. This message is sent unsecure\n and is visible to\n attacker.",
            "heading": "Hello SSL!"
        ],
        [
            "image": "hellossl2",
            "tooltip": "Server responds with its public key\n to you (say RSA). Now you and attacker\n both have server's public key. Anything locked\n with this key cannot be unlocked\n with this same key.",
            "heading": "Public Server Key"
        ],
        [
            "image": "symmetric",
            "tooltip": "You create your special key and lock your key with\n server's public key. You send this to server. Now attacker\n can see your message but cannot unlock it to get YOUR special\n key because attacker does not have server's private\n key. (Learn about RSA to know more!)",
            "heading": "Sending your private key to server",
            ],
        [
            "image": "handshake-4step",
            "tooltip": "Server receives your locked\n message and unlocks it with its own private\n key to get your special key.",
            "heading": "Messaging begins",
            "spriteFrames": "23",
            "delay": "0.03"
        ],
        [
            "image": "handshake-5step",
            "tooltip": "For any further communication, both you\n and server lock their messages with your special key,\n send it over unsecured wire, and unlock with\n that same special key. Attacker cannot see any messages, just\n the garbage (encrypted) values.",
            "heading": "YAY!",
            "spriteFrames": "34",
            "delay": "0.04"
        ]
    ],
    
    "dns": [
        [
            "image": "you",
            "tooltip": "This is you. Hello!",
            "heading": "LETS GO!",
            "spriteFrames": "8",
            "delay": "0.1"
        ],
        [
            "image": "dns1",
            "tooltip": "When you first search for example.com\n on your browser, your operating system would try\n to determine if they know the IP address\n of example.com already (from cache)",
            "heading": "Going to example.com"
        ],
        [
            "image": "resolvingns",
            "tooltip": "Let's assume the IP address is not in the\n cache. Your OS is configured to ask resolving \nname server (say, your ISP) for IP addresses\n it does not know.",
            "heading": "Asking Resolving Name Server"
        ],
        [
            "image": "rootns",
            "tooltip": "The resolving name server may or may not have\n that in cache. If not, it contacts THE ROOT\n name server (which is always present in the\n resolving name server)",
            "heading": "Asking Root Name Server"
        ],
        [
            "image": "hellorns",
            "tooltip": "The root name server know details about\n other name servers which hold information\n for top-level-domains\n like .com, .net, .in, .us, etc.",
            "heading": "What is Root Name Server?"
        ],
        [
            "image": "rootnsmain",
            "tooltip": "The root name server in this case redirects\n the resolving name server\n to .com (example.com, remember?) TLD name server",
            "heading": "What next?"
        ],
        [
            "image": "tldns",
            "tooltip": "The .com TLD name server redirects resolving name\n server to authoratative name server (ANS) which surely knows\n the final IP address of example.com",
            "heading": "OKAY! What happens now?"
        ],
        [
            "image": "ans",
            "tooltip": "With the help of domain's registrar!\n (For example: GoDaddy, namecheap, etc.) When\n someone purchases domain from them, they notify\n the organization responsible for TLD and tell\n them to update TLD name servers.",
            "heading": "How did .com NS know which ANS to use?"
        ],
        [
            "image": "response",
            "tooltip": "The resolving name server finally gets the IP address\n from authoritative name server and gives it to your operating\n system, which your OS gives\n to browser.",
            "heading": "Getting IP address"
        ],
        [
            "image": "browser",
            "tooltip": "Your browser can now access and connect to the\n IP address and download contents from that\n particular server.",
            "heading": "YAY!"
        ]
    ],
    
    "rsa": [
        [
            "image": "you",
            "tooltip": "This is you. Hello!",
            "heading": "Hello You!",
            "spriteFrames": "8",
            "delay": "0.1"
        ],
        [
            "image": "bob",
            "tooltip": "This is Bob. Hello Bob!",
            "heading": "Bob",
            "spriteFrames": "12",
            "delay": "0.1"
        ],
        [
            "image": "secretmsg",
            "tooltip": "Let's say you want to send Bob a\n secret message which no-one else should\n be able to read. One way is to use\n a symmetric way.",
            "heading": "A secret message!",
            ],
        [
            "image": "symmetric",
            "tooltip": "In symmetric encryption, you both\n need to know a special 'key' with which you\n both are going to encrypt/decrypt\n your message. Somehow, you both need\n to share the key first.",
            "heading": "What is symmetric encryption?",
            ],
        [
            "image": "cross",
            "tooltip": "Not so good. If someone\n gets hold of the key while you're\n sending it to Bob, all your\n communications can be seen by attacker.",
            "heading": "Why not symmetric encryption?"
        ],
        [
            "image": "keypair",
            "tooltip": "To fix this, we use asymmetric\n encryption - a key which locked your message\n cannot be used to unlock it.\n Only its counterpart can unlock the message.",
            "heading": "Asymmetric encryption"
        ],
        [
            "image": "questionmark",
            "tooltip": "Let's see it this way: We see that\n 97 * 7 = 679 Now given only 679, you cannot tell which 2\n numbers to multiply to get 679 unless you try\n out every combination of prime\n multiplication upto a certain extent.",
            "heading": "Why This Works?"
        ],
        [
            "image": "lightbulb",
            "tooltip": "Theoritically, you can decrypt messages from\n public key itself, but you have huge chunks\n of missing information (like factorization\n of 1000 digit number) which is practically impossible to try\n out with current computation power.",
            "heading": "Why This Works?"
        ],
        [
            "image": "keypair",
            "tooltip": "Now you generate 2 keys which are \nmathematically linked with each other. Let's say \nKEY YOU_PUBL is your public key and KEY YOU_PRIV is your\n private key. You release KEY \nYOU_PUBL on internet accessible to everybody",
            "heading": "Generating key-pair"
        ],
        [
            "image": "youpublic",
            "tooltip": "Now you encrypt your message with KEY\n YOU_PRIV (your private key). Now sure\n enough, KEY YOU_PUBL which is released on\n internet can be used to unlock your message.",
            "heading": "Encrypting with your private key",
            "spriteFrames": "67",
            "delay": "0.04"
        ],
        [
            "image": "youpriv",
            "tooltip": "But instead, what you do, is after\n encrypting your message with your private\n KEY YOU_PRIV, you encrypt the message again\n with Bob's public KEY BOB_PUBL",
            "heading": "Encrypting with Bob's public key",
            "spriteFrames": "50",
            "delay": "0.04"
        ],
        [
            "image": "bobpriv",
            "tooltip": "Since nobody has access to Bob's private\n KEY BOB_PRIV but Bob, only Bob can\n decrypt the first layer of encryption and get your\n encrypted message with your private key.",
            "heading": "Decrypting with bob's private key",
            "spriteFrames": "73",
            "delay": "0.04"
        ],
        [
            "image": "bobpublic",
            "tooltip": "KEY YOU_PUBL is online. Thus Bob can decrypt\n your second layer of encryption and would be assured\n that only you sent this message \n(because YOUR public key can only\n decode messages encrypted by YOUR private key)",
            "heading": "Decrypting with your public key",
            "spriteFrames": "63",
            "delay": "0.04"
        ],
        [
            "image": "check",
            "tooltip": "At this point, Bob is sure that the message\n was sent by you, and you are sure that only Bob\n can read that message even if someone in between\n gets hold of the data you're transmitting.",
            "heading": "YAY!"
        ]
    ]
]
