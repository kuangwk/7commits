members = []

for i in [1..4]
    member = 
        name: "member#{i}"
    members.push member

module.exports.members = members