World(FactoryGirl::Syntax::Methods)

# TODO These are in the wrong place - need to be in a data migration
[ {name:'payment',direction:1},
  {name:'withdrawal',direction:-1},
  {name:'transfer_in',direction:1},
  {name:'transfer_out',direction:-1},
].each { |entry| Entry.find_by_name(entry[:name]) || Entry.create(entry) }

