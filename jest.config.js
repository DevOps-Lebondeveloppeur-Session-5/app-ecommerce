// jest.config.js
module.exports = {
    testEnvironment: 'jest-environment-jsdom',
    moduleNameMapper: {
      '\\.(css|scss|sass)$': 'identity-obj-proxy',        // Mocks CSS imports
      '\\.(jpg|jpeg|png|gif|webp|svg)$': '<rootDir>/__mocks__/fileMock.js' // Mocks image imports
    }
  };
  