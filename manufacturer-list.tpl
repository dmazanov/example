{*
* 2007-2012 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2012 PrestaShop SA
*  @version  Release: $Revision: 6594 $
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{capture name=path}{l s='Manufacturers'}{/capture}
{include file="$tpl_dir./breadcrumb.tpl"}

<h1>{l s='Manufacturers'}</h1>

{if isset($errors) AND $errors}
	{include file="$tpl_dir./errors.tpl"}
{else}
	<p class="nbrmanufacturer">{strip}
		<span class="bold">
			{if $nbManufacturers == 0}{l s='There are no manufacturers.'}
			{else}
				{if $nbManufacturers == 1}
					{l s='There is %d manufacturer.' sprintf=$nbManufacturers}
				{else}
					{l s='There are %d manufacturers.' sprintf=$nbManufacturers}
				{/if}
			{/if}
		</span>{/strip}
	</p>
	{if $nbManufacturers > 0}
		<ul id="manufacturers_list" class="clearfix">
		{foreach from=$manufacturers item=manufacturer name=manufacturers}
			{if !isset($currentLetter)}
				{$currentLetter = $manufacturer.name|substr:0:1}
				<li class="alphabetical"><h3>{if in_array($currentLetter, array(0,1,2,3,4,5,6,7,8,9))}0-9{else}{$manufacturer.name|substr:0:1}{/if}</h3></li>
			{else if isset($currentLetter) && $currentLetter != $manufacturer.name|substr:0:1 && (string)($manufacturer.name|substr:0:1) != (string)((int)($manufacturer.name|substr:0:1))}	
				{$currentLetter = $manufacturer.name|substr:0:1}
				<li class="alphabetical"><h3>{$manufacturer.name|substr:0:1}</h3></li>
			{/if}	
			<li class="clearfix {if $smarty.foreach.manufacturers.first}first_item{elseif $smarty.foreach.manufacturers.last}last_item{else}item{/if}"> 
				<div class="left_side">
					<!-- name -->
					<h4>
						{if $manufacturer.nb_products > 0}<a href="{$link->getmanufacturerLink($manufacturer.id_manufacturer, $manufacturer.link_rewrite)|escape:'htmlall':'UTF-8'}">{/if}
						{$manufacturer.name|truncate:60:'...'|escape:'htmlall':'UTF-8'}
						{if $manufacturer.nb_products > 0}</a>{/if}
					</h4>
				</div>
			</li>
		{/foreach}
		</ul>
	{/if}
{/if}
 