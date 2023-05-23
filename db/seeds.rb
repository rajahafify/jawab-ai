return if Factory.all.count > 0
factory = Factory.create(
  name: 'Ikhlas.com',
  description: 'Ikhlas.com is a website that provides a platform for people to donate to the needy.',
  url: 'http://ikhlas.com',
)

container = factory.containers.create(
  name: 'Ikhlas.com Qurban',
  description: 'Ikhlas.com Qurban is a container for people to donate for qurban.',
)

