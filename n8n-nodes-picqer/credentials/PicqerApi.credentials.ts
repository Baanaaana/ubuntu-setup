import {
	ICredentialType,
	INodeProperties,
} from 'n8n-workflow';

export class PicqerApi implements ICredentialType {
	name = 'picqerApi';
	displayName = 'Picqer API';
	documentationUrl = 'https://picqer.com/en/api';
	properties: INodeProperties[] = [
		{
			displayName: 'Subdomain',
			name: 'subdomain',
			type: 'string',
			default: '',
			placeholder: 'example',
			description: 'The subdomain of your Picqer account (example.picqer.com)',
		},
		{
			displayName: 'API Key',
			name: 'apiKey',
			type: 'string',
			typeOptions: {
				password: true,
			},
			default: '',
			description: 'The API key obtained from Picqer',
		},
	];
} 