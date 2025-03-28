import { render, fireEvent } from '@testing-library/svelte';
import App from './App.svelte';
import Gun from 'gun';

jest.mock('gun');

describe('App component', () => {
  let gunInstance;

  beforeEach(() => {
    gunInstance = {
      get: jest.fn().mockReturnThis(),
      put: jest.fn((data, callback) => callback({})),
      once: jest.fn((callback) => callback({ value: 'test value' }))
    };
    Gun.mockImplementation(() => gunInstance);
  });

  test('should render the main layout and components', () => {
    const { getByText, getByLabelText } = render(App);

    expect(getByText('Knowledge Engine')).toBeInTheDocument();
    expect(getByLabelText('Key:')).toBeInTheDocument();
    expect(getByLabelText('Value:')).toBeInTheDocument();
    expect(getByText('Save')).toBeInTheDocument();
    expect(getByText('Load')).toBeInTheDocument();
  });

  test('should save data to Gun.js database', async () => {
    const { getByLabelText, getByText } = render(App);

    const keyInput = getByLabelText('Key:');
    const valueInput = getByLabelText('Value:');
    const saveButton = getByText('Save');

    await fireEvent.input(keyInput, { target: { value: 'testKey' } });
    await fireEvent.input(valueInput, { target: { value: 'testValue' } });
    await fireEvent.click(saveButton);

    expect(gunInstance.get).toHaveBeenCalledWith('data');
    expect(gunInstance.put).toHaveBeenCalledWith({ testKey: 'testValue' });
  });

  test('should load data from Gun.js database', async () => {
    const { getByLabelText, getByText } = render(App);

    const keyInput = getByLabelText('Key:');
    const loadButton = getByText('Load');

    await fireEvent.input(keyInput, { target: { value: 'testKey' } });
    await fireEvent.click(loadButton);

    expect(gunInstance.get).toHaveBeenCalledWith('data');
    expect(gunInstance.once).toHaveBeenCalled();
    expect(getByLabelText('Value:').value).toBe('test value');
  });
});
