import {
	IExecuteFunctions,
	INodeExecutionData,
	INodeType,
	INodeTypeDescription,
	ILoadOptionsFunctions,
	IHttpRequestOptions,
} from 'n8n-workflow';

export class Picqer implements INodeType {
	description: INodeTypeDescription = {
		displayName: 'Picqer',
		name: 'picqer',
		icon: 'file:picqer.svg',
		group: ['transform'],
		version: 1,
		subtitle: '={{$parameter["operation"] + ": " + $parameter["resource"]}}',
		description: 'Consume Picqer API',
		defaults: {
			name: 'Picqer',
		},
		inputs: ['main'],
		outputs: ['main'],
		credentials: [
			{
				name: 'picqerApi',
				required: true,
			},
		],
		properties: [
			{
				displayName: 'Resource',
				name: 'resource',
				type: 'options',
				noDataExpression: true,
				options: [
					{
						name: 'Customer',
						value: 'customer',
					},
					{
						name: 'Order',
						value: 'order',
					},
					{
						name: 'Product',
						value: 'product',
					},
					{
						name: 'Return',
						value: 'return',
					},
					{
						name: 'Stock',
						value: 'stock',
					},
					{
						name: 'Warehouse',
						value: 'warehouse',
					},
					{
						name: 'Picklist',
						value: 'picklist',
					},
					{
						name: 'Purchase Order',
						value: 'purchaseorder',
					},
				],
				default: 'customer',
			},
			{
				displayName: 'Operation',
				name: 'operation',
				type: 'options',
				noDataExpression: true,
				displayOptions: {
					show: {
						resource: ['customer'],
					},
				},
				options: [
					{
						name: 'Create',
						value: 'create',
						description: 'Create a new customer',
						action: 'Create a customer',
					},
					{
						name: 'Get',
						value: 'get',
						description: 'Get a customer by ID',
						action: 'Get a customer',
					},
					{
						name: 'Get All',
						value: 'getAll',
						description: 'Get all customers',
						action: 'Get all customers',
					},
					{
						name: 'Update',
						value: 'update',
						description: 'Update a customer',
						action: 'Update a customer',
					},
					{
						name: 'Delete',
						value: 'delete',
						description: 'Delete a customer',
						action: 'Delete a customer',
					},
				],
				default: 'create',
			},
			{
				displayName: 'Operation',
				name: 'operation',
				type: 'options',
				displayOptions: {
					show: {
						resource: ['order'],
					},
				},
				options: [
					{
						name: 'Create',
						value: 'create',
						description: 'Create a new order',
						action: 'Create an order',
					},
					{
						name: 'Get',
						value: 'get',
						description: 'Get an order by ID',
						action: 'Get an order',
					},
					{
						name: 'Get All',
						value: 'getAll',
						description: 'Get all orders',
						action: 'Get all orders',
					},
					{
						name: 'Update',
						value: 'update',
						description: 'Update an order',
						action: 'Update an order',
					},
					{
						name: 'Close',
						value: 'close',
						description: 'Close an order',
						action: 'Close an order',
					},
				],
				default: 'create',
			},
			{
				displayName: 'Operation',
				name: 'operation',
				type: 'options',
				displayOptions: {
					show: {
						resource: ['product'],
					},
				},
				options: [
					{
						name: 'Create',
						value: 'create',
						description: 'Create a new product',
						action: 'Create a product',
					},
					{
						name: 'Get',
						value: 'get',
						description: 'Get a product by ID',
						action: 'Get a product',
					},
					{
						name: 'Get All',
						value: 'getAll',
						description: 'Get all products',
						action: 'Get all products',
					},
					{
						name: 'Update',
						value: 'update',
						description: 'Update a product',
						action: 'Update a product',
					},
					{
						name: 'Update Stock',
						value: 'updateStock',
						description: 'Update product stock',
						action: 'Update product stock',
					},
				],
				default: 'create',
			},
			{
				displayName: 'ID',
				name: 'id',
				type: 'string',
				default: '',
				required: true,
				displayOptions: {
					show: {
						operation: ['get', 'update', 'delete'],
					},
				},
				description: 'ID of the resource',
			},
			{
				displayName: 'Return All',
				name: 'returnAll',
				type: 'boolean',
				default: false,
				description: 'Whether to return all results or only up to a given limit',
				displayOptions: {
					show: {
						operation: ['getAll'],
					},
				},
			},
			{
				displayName: 'Limit',
				name: 'limit',
				type: 'number',
				default: 100,
				description: 'Max number of results to return',
				displayOptions: {
					show: {
						operation: ['getAll'],
						returnAll: [false],
					},
				},
			},
			{
				displayName: 'Name',
				name: 'name',
				type: 'string',
				default: '',
				displayOptions: {
					show: {
						resource: ['customer'],
						operation: ['create'],
					},
				},
				required: true,
				description: 'Name of the customer',
			},
			{
				displayName: 'Contact Name',
				name: 'contactname',
				type: 'string',
				default: '',
				displayOptions: {
					show: {
						resource: ['customer'],
						operation: ['create'],
					},
				},
				description: 'Contact name of the customer',
			},
			{
				displayName: 'Email',
				name: 'emailaddress',
				type: 'string',
				default: '',
				displayOptions: {
					show: {
						resource: ['customer'],
						operation: ['create'],
					},
				},
				description: 'Email address of the customer',
			},
			{
				displayName: 'Product Code',
				name: 'productcode',
				type: 'string',
				default: '',
				displayOptions: {
					show: {
						resource: ['product'],
						operation: ['create', 'update'],
					},
				},
				description: 'Code of the product',
			},
			{
				displayName: 'Stock',
				name: 'stock',
				type: 'number',
				default: 0,
				displayOptions: {
					show: {
						resource: ['product'],
						operation: ['updateStock'],
					},
				},
				description: 'Current stock of the product',
			},
		],
	};

	async execute(this: IExecuteFunctions): Promise<INodeExecutionData[][]> {
		const items = this.getInputData();
		const returnData: INodeExecutionData[] = [];
		
		const resource = this.getNodeParameter('resource', 0) as string;
		const operation = this.getNodeParameter('operation', 0) as string;
		const credentials = await this.getCredentials('picqerApi');

		const subdomain = credentials.subdomain as string;
		const baseUrl = `https://${subdomain}.picqer.com/api/v1`;

		for (let i = 0; i < items.length; i++) {
			try {
				let response;
				const options: IHttpRequestOptions = {
					headers: {
						'Content-Type': 'application/json',
						'User-Agent': 'N8N Picqer Node',
						'Authorization': `Basic ${Buffer.from(credentials.apiKey + ':').toString('base64')}`,
					},
				};

				if (operation === 'getAll') {
					const returnAll = this.getNodeParameter('returnAll', i) as boolean;
					const limit = this.getNodeParameter('limit', i, 100) as number;
					
					let items: any[] = [];
					let offset = 0;

					do {
						options.method = 'GET';
						options.url = `${baseUrl}/${resource}s?offset=${offset}`;
						
						const responseData = await this.helpers.httpRequest(options);
						items.push.apply(items, responseData);
						
						if (!returnAll && items.length >= limit) {
							items = items.slice(0, limit);
							offset = items.length;
						} else {
							offset += 100;
						}
					} while (returnAll && offset < 10000);

					response = items;
				} else {
					switch (`${resource}.${operation}`) {
						case 'customer.create':
							const name = this.getNodeParameter('name', i) as string;
							const contactname = this.getNodeParameter('contactname', i) as string;
							const emailaddress = this.getNodeParameter('emailaddress', i) as string;

							const body = {
								name,
								contactname,
								emailaddress,
							};

							options.method = 'POST';
							options.url = `${baseUrl}/customers`;
							options.body = body;
							
							response = await this.helpers.httpRequest(options);
							break;

						case 'product.updateStock':
							const productId = this.getNodeParameter('id', i) as string;
							const stock = this.getNodeParameter('stock', i) as number;
							
							options.method = 'POST';
							options.url = `${baseUrl}/products/${productId}/stock`;
							options.body = { stock };
							
							response = await this.helpers.httpRequest(options);
							break;

						default:
							throw new Error(`Unsupported operation: ${resource}.${operation}`);
					}
				}

				returnData.push({ json: response });
			} catch (error) {
				if (this.continueOnFail()) {
					returnData.push({ json: { error: error.message } });
					continue;
				}
				throw error;
			}
		}

		return [returnData];
	}
} 