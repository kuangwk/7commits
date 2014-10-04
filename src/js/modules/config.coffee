config = {}
config.testing = !!(window.navigator.userAgent.match /PhantomJS/i)

module.exports = config