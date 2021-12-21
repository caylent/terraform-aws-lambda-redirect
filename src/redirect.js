'use strict';
module.exports.handler = async (event, context) => {
  const response = {
    statusCode: 302,
    headers: {
      Location: process.env.REDIRECT_LOCATION,
    }
  };
  return response;
}
